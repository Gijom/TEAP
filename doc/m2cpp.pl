#!/usr/bin/perl
#Copyright (c) 2009, Fabrice
#All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are
#met:
#
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in
#      the documentation and/or other materials provided with the distribution
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
#LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#POSSIBILITY OF SUCH DAMAGE.
if ($#ARGV != 0)
{
  die "Argument must contain filename $#ARGV"
}
else
{
  $fname=$ARGV[0];
}

# If we have a .m file inside a (@)-folder with the same name :
# we will read each file of this folder
if ($fname =~ /^(.*)\@([\d\w-_]*)[\/\\](\2)\.m/)
{
  $name = $2;
  $nameExt = $name.".m";
  $dir = $1."@".$name."/\*.m";
  @fic = glob($dir);
  $i = 0;
  @listeFic[0] = $fname;
  foreach $my_test (@fic)
  {
    if (!($my_test =~ $nameExt))
    {
      $i++;
      @listeFic[$i] = $my_test;
    }
  }
}
# otherwise @-folder, but .m with a different name : ignore it
elsif ($fname =~ /^(.*)\@([\d\w-_]*)[\/\\](.*)\.m/)
{
}
# otherwise
else
{
  @listeFic[0] = $fname;
}
$output = "";
foreach $my_fic (@listeFic)
{

  open(my $in, $my_fic);

  $declTypeDef="";
  $inClass = 0;
  $inAbstractMethodBlock = 0;
  $listeProperties = 0;
  $listeEnumeration = 0;

  $methodAttribute = "";


  while (<$in>)
  {
    if (/(^\s*)(%>)(.*)/)
    {
      $output=$output."$1///$3";
    }
    if (($listeProperties == 1) && (/(^\s*\bend\b\s*)/))
    {
      $listeProperties = 0;
    }
    if (($inAbstractMethodBlock == 1) && (/(^\s*\bend\b\s*)/))
    {
      $inAbstractMethodBlock = 0;
    }
    if (($listeProperties == 1) && (/^\s*([\w\d]*)\s*(=\s*[\w\d{}'',\s\[\]\.]*)?.*(%>.*)?/))
    {
      $propertyName = $1;
      $propertyValue = $2;
      $propertyComment = $3;
      if (!($propertyName =~ /^$/))
      {
        if ($typeProperties =~ /Constant/)
        {
          $properties = $propertyName."$propertyValue;$propertyComment";
        }
        else
        {
          $properties = $propertyName.";$propertyComment";
        }

        $properties =~ s/%>/\/\/\//g;
        $properties =~ s/%/\/\//g;
        $output=$output.$typeProperties."Property ".$properties;
      }
    }
    if (($listeEnumeration == 1) && (/(^\s*\bend\b\s*)/))
    {
      $listeEnumeration = 0;
      $output=$output."};";
    }
    if (($listeEvents == 1) && (/(^\s*\bend\b\s*)/))
    {
      $listeEvents = 0;
      $output=$output."};";
    }
    if (($listeEvents == 1) && (/^\s*([\w\d]*)\s*/))
    {
      $name_event = $1;
      if (!($name_event =~ /^$/))
      {
        $event = $name_event.",";
        $event =~ s/%>/\/\/\//g;
        $event =~ s/%/\/\//g;
        $output=$output.$event;
      }
    }
    if (($listeEnumeration == 1) && (/^\s*([\w\d]*)\s*(\(.*\))?(%>.*)?/))
    {
      $name_enum = $1;
      $val_enum = $2;
      if (!($name_enum =~ /^$/))
      {
        if (!($val_enum =~ /^$/))
        {
          $enum = "$name_enum=$val_enum,";
          $enum =~ s/%>/\/\/\//g;
          $enum =~ s/%/\/\//g;
          $output=$output.$enum;
        }
        else
        {
          $enum = "$name_enum,";
          $enum =~ s/%>/\/\/\//g;
          $enum =~ s/%/\/\//g;
          $output=$output.$enum;
        }
      }
    }
    if (/(^\s*function)\s*([\] \w\d,_\[]+=)?\s*([.\w\d_-]*)\s*\(?([\w\d\s,~]*)\)?(%?.*)/)
    {
      $functionKeyWord = $1;
      $functionName = $3;
      $arguments = $4;
      if ($inClass == 0)
      {
        $output = $declTypeDef.$output;
        $declTypeDef = "";
      }
      $arguments =~ s/,/,in /g;
      $arguments =~ s/~/ignoredArg/g;
      $arguments = "in $arguments";
      if ($arguments =~ /^in $/)
      {
        $arguments = "";
      }
      $ligne = "$methodAttribute $functionKeyWord $functionName($arguments);"; 
      $output=$output.$ligne;
    }
    # Signature of functions in abstract methods
    elsif ((/^\s*([\] \w\d,_\[]+=)?\s*([.\w\d_-]+)\s*\(?([\w\d\s,~]*)\)?(%?.*)/) & ($inAbstractMethodBlock == 1) )
    {
      $functionName = $2;
      $arguments = $3;
      $arguments =~ s/,/,in /g;
      $arguments =~ s/~/ignoredArg/g;
      $arguments = "in $arguments";
      if ($arguments =~ /^in $/)
      {
        $arguments = "";
      }
      $ligne = "$methodAttribute $functionKeyWord $functionName($arguments);"; 
      $output=$output.$ligne;
    }
    # inheritance for classes
    if (/(^\s*classdef)\s*(\s*\([\{\}\?\w,=\s]+\s*\))?\s*([\w\d_]+)\s*<?\s*([\s\w\d._&]+)?(.*)/) 
    {
      $className = $3;
      $classInheritance = $4;
      $classAttributes = $2;
      if (!($classInheritance =~ /^$/))
      {
        $classInheritance =~ s/&/,public /g;
        $classDef = "class ".$className.":public $classInheritance";
      }
      else
      {
        $classDef = "class ".$className;
      }
      $output=$output.$classDef;
      $output=$output."{";
      $output=$output.$declTypeDef;
      $output=$output."public:\n";
      $inClass = 1;
    }
    if (/(^\s*properties)\s*(\s*\([\w,=\s]+\s*\))?(.*)/)
    {
      $listeProperties = 1;
      $propertiesAttributes = $2;
      $typeProperties = "public:\n";
      if (lc($propertiesAttributes) =~ /(access\s*=\s*private)/)
      {
        $typeProperties = "private:\n"
      }
      elsif (lc($propertiesAttributes) =~ /(access\s*=\s*public)/)
      {
        $typeProperties = "public:\n"
      }
      elsif (lc($propertiesAttributes) =~ /(access\s*=\s*protected)/)
      {
        $typeProperties = "protected:\n"
      }
      if ((lc($propertiesAttributes) =~ /(constant\s*=\s*false)/) || (lc($propertiesAttributes) =~ /(~constant)/))
      {
      }
      elsif (lc($propertiesAttributes) =~ /(constant(\s*=\s*true\s*)?)/)
      {
        $typeProperties = $typeProperties." Constant ";
      }
    }
    if (/(^\s*enumeration)\s*(.*)/)
    {
      $listeEnumeration = 1;
      $output=$output."public:\nenum ".$className." {";
    }
    if (/(^\s*events)\s*(.*)/)
    {
      $listeEvents = 1;
      $output=$output."public:\nenum Events {";
    }
    if (/(^\s*methods)\s*(\s*\([\w,=\s]+\s*\))?(.*)/)
    {
      $methodAttribute = "public:\n";
      $methodsAttributes = $2;
      if (lc($methodsAttributes) =~ /(access\s*=\s*private)/)
      {
        $methodAttribute = "private:\n"
      }
      elsif (lc($methodsAttributes) =~ /(access\s*=\s*protected)/)
      {
        $methodAttribute = "protected:\n"
      }
      elsif (lc($methodsAttributes) =~ /(access\s*=\s*public)/)
      {
        $methodAttribute = "public:\n"
      }
      if (lc($methodsAttributes) =~ /(abstract(\s*=\s*true\s*)?)/)
      {
        $inAbstractMethodBlock = 1;
        $methodAttribute = $methodAttribute." virtual ";
      }
      if ((lc($methodsAttributes) =~ /(static\s*=\s*false)/) || (lc($methodsAttributes) =~ /(~static)/))
      {
      }
      elsif (lc($methodsAttributes) =~ /(static(\s*=\s*true\s*)?)/)
      {
        $methodAttribute = $methodAttribute." static";
      }
    }
    $output=$output."\n";
  }
  close $in;
}
$output=$output."};\n";
print $output;
