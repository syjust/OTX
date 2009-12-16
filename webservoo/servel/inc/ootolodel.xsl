<?xml version="1.0" encoding="UTF-8"?>
<!--
 # The Contents of this file are made available subject to the terms of
 # the GNU Lesser General Public License Version 2.1

 # Nicolas Barts, Cléo/Revue.org
 # copyright 2009

 # This stylesheet is derived from the OpenOffice to TEIP5 conversion
 # Sebastian Rahtz / University of Oxford, copyright 2005
 #  derived from the OpenOffice to Docbook conversion
 #  Sun Microsystems Inc., October, 2000

 #  GNU Lesser General Public License Version 2.1
 #  =============================================
 #  Copyright 2000 by Sun Microsystems, Inc.
 #  901 San Antonio Road, Palo Alto, CA 94303, USA
 #
 #  This library is free software; you can redistribute it and/or
 #  modify it under the terms of the GNU Lesser General Public
 #  License version 2.1, as published by the Free Software Foundation.
 #
 #  This library is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 #  Lesser General Public License for more details.
 #
 #  You should have received a copy of the GNU Lesser General Public
 #  License along with this library; if not, write to the Free Software
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 #  MA  02111-1307  USA
 #
-->
<xsl:stylesheet
  exclude-result-prefixes="office style text table draw fo xlink dc meta number svg chart dr3d math form script ooo ooow oooc dom xforms xsd xsi"
  office:version="1.0" version="1.0" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dom="http://www.w3.org/2001/xml-events"
  xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
  xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
  xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
  xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
  xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
  xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
  xmlns:ooo="http://openoffice.org/2004/office"
  xmlns:oooc="http://openoffice.org/2004/calc"
  xmlns:ooow="http://openoffice.org/2004/writer"
  xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
  xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
  xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
  xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
  xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
  xmlns:xforms="http://www.w3.org/2002/xforms"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="META" select="/"/>

    <xsl:output encoding="UTF-8" indent="yes"/>
    <!--
    <xsl:strip-space elements="text:span"/>
    -->
    <xsl:preserve-space elements="*" />


<!--
    office:document
-->
    <xsl:template match="/office:document">
    <TEI xmlns="http://www.tei-c.org/ns/1.0">
        <xsl:call-template name="teiHeader"/>
        <xsl:apply-templates/>
    </TEI>
    </xsl:template>

<!-- 
    teiHeader
-->
    <xsl:template name="teiHeader">
    <teiHeader>
      <fileDesc>
        <titleStmt>
          <title>
            <xsl:value-of select="/office:document/office:meta/dc:title"/>
          </title>
          <author>
            <xsl:value-of select="/office:document/office:meta/meta:initial-creator"/>
          </author>
        </titleStmt>
        <editionStmt>
          <edition>
            <date>
              <xsl:value-of select="/office:document/office:meta/meta:creation-date"/>
            </date>
          </edition>
        </editionStmt>
        <publicationStmt>
          <authority/>
        </publicationStmt>
        <sourceDesc>
          <p>
	    <xsl:apply-templates select="/office:document/office:meta/meta:generator"/>
	    <xsl:text>Written by OpenOffice</xsl:text>
	  </p>
        </sourceDesc>
      </fileDesc>
      <xsl:if test="/office:document/office:meta/dc:language|/office:document/office:meta/meta:keyword">
	<profileDesc>
	  <xsl:if test="/office:document/office:meta/dc:language">
	    <langUsage>
	      <language>
		<xsl:attribute name="ident">
		  <xsl:value-of select="/office:document/office:meta/dc:language"/>
		</xsl:attribute>
		<xsl:value-of select="/office:document/office:meta/dc:language"/>
	      </language>
	    </langUsage>
	  </xsl:if>
	  <xsl:if test="/office:document/office:meta/meta:keyword">
	    <textClass>
	      <keywords>
		<list>
		  <xsl:for-each select="/office:document/office:meta/meta:keyword">
		    <item><xsl:value-of select="."/></item>
		  </xsl:for-each>
		</list>
	      </keywords>
	    </textClass>
	  </xsl:if>
	</profileDesc>
      </xsl:if>
      <encodingDesc>
      </encodingDesc>
      <revisionDesc>
	<change>
	  <name>
	    <xsl:apply-templates select="/office:document/office:meta/dc:creator"/>
	  </name>
	  <date>
	    <xsl:apply-templates select="/office:document/office:meta/dc:date"/>
	  </date>
	</change>
      </revisionDesc>
    </teiHeader>
  </xsl:template>


<!-- office:body -->
    <xsl:template match="/office:document/office:body">
        <text>
            <front></front>
            <xsl:apply-templates/>
            <back></back>
        </text>
    </xsl:template>

<!-- office:text -->
    <xsl:template match="office:text">
        <body>
        <xsl:apply-templates/>
        </body>
    </xsl:template>


    <!-- special case paragraphs -->
    <xsl:template match="text:p[@text:style-name='XMLComment']">
        <xsl:comment>
            <xsl:value-of select="."/>
        </xsl:comment>
    </xsl:template>

    <!-- paragraphs -->
    <xsl:template match="text:p[@text:style-name]">
    <xsl:choose>
        <xsl:when test="contains(@text:style-name,'_')"> 
            <xsl:variable name="rend">
                <xsl:value-of select="substring-before(@text:style-name,'_')"/>  
            </xsl:variable>
            <xsl:variable name="rendition">
                <xsl:value-of select="substring-after(@text:style-name,'_')"/>  
            </xsl:variable>
            <xsl:choose>
                <!-- cellules des tableaux -->
                <xsl:when test="parent::table:table-cell">
                    <s rend="{$rend}" rendition="#{$rendition}"><xsl:apply-templates/></s>
                </xsl:when>
                <xsl:otherwise>
                    <p rend="{$rend}" rendition="#{$rendition}">
                    <xsl:apply-templates/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="rend">
                <xsl:value-of select="@text:style-name"/>  
            </xsl:variable>
            <xsl:choose>
                <!-- cellules des tableaux -->
                <xsl:when test="parent::table:table-cell">
                    <s rend="{$rend}"><xsl:apply-templates/></s>
                </xsl:when>
                <xsl:otherwise>
                    <p rend="{$rend}">
                    <xsl:apply-templates/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
    </xsl:template>


  <xsl:template match="office:annotation/text:p">
    <note>
        <xsl:apply-templates/>
    </note>
  </xsl:template>

  <!-- TODO : normal paragraphs ?? -->


  <!-- lists -->

    <!-- headings -->
    <xsl:template match="text:list[@text:style-name='outline']">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="text:list[@text:continue-numbering='true']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:h[@text:outline-level]">
        <xsl:variable name="level">
            <xsl:value-of select="concat('level', @text:outline-level)"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains(@text:style-name,'_')"> 
                <xsl:variable name="rend">
                    <xsl:value-of select="substring-before(@text:style-name,'_')"/>  
                </xsl:variable>
                <xsl:variable name="rendition">
                    <xsl:value-of select="substring-after(@text:style-name,'_')"/>  
                </xsl:variable>
                <!--
                <p rend="{$rend}" rendition="#{$rendition}">
                    <xsl:apply-templates/>
                </p>
                -->
                <ab type="header" subtype="{$level}" rend="{$rend}" rendition="#{$rendition}">
                <xsl:apply-templates/>
                </ab>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="rend">
                    <xsl:value-of select="@text:style-name"/>  
                </xsl:variable>
                <!--
                <p rend="{$rend}">
                    <xsl:apply-templates/>
                </p>
                -->
                <ab type="header" subtype="{$level}" rend="{$rend}">
                <xsl:apply-templates/>
                </ab>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- list -->
    <xsl:template match="text:list">
        <xsl:choose>
            <xsl:when test="text:list-item/text:h">
                <xsl:for-each select="text:list-item">
                    <xsl:apply-templates/>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@text:style-name='Var List'">
                <list><xsl:apply-templates/></list>
            </xsl:when>
            <xsl:when test="starts-with(@text:style-name,'ordered')">
                <list type="ordered">
                <xsl:apply-templates/>
                </list>
            </xsl:when>
            <xsl:otherwise>
                <list type="unordered">
                <xsl:apply-templates/>
                </list>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="text:list-header">
        <head><xsl:apply-templates/></head>
    </xsl:template>

    <xsl:template match="text:list-item">
        <xsl:choose>
            <xsl:when test="parent::text:list/@text:style-name='outline'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="parent::text:list/@text:continue-numbering='true'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="parent::text:list/@text:style-name='Var List'">
                <item>
                <xsl:for-each select="text:p[@text:style-name='VarList Term']">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
                </item>
            </xsl:when>
            <xsl:otherwise>
                <item><xsl:apply-templates/></item>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- inline -->
    <xsl:template match="text:span">
        <xsl:variable name="Style">
            <xsl:value-of select="@text:style-name"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$Style='marquedecommentaire'"> 
                <!-- commentaires genre mode revision -->
            </xsl:when>
            <xsl:when test="$Style='emphasis'">
                <emph><xsl:apply-templates/></emph>
            </xsl:when>
            <xsl:when test="$Style='underline'">
                <hi rend="ul"><xsl:apply-templates/></hi>
            </xsl:when>
            <xsl:when test="$Style='smallCaps'">
                <hi rend="sc"><xsl:apply-templates/></hi>
            </xsl:when>
            <xsl:when test="$Style='emphasisbold'">
                <emph rend="bold"><xsl:apply-templates/></emph>
            </xsl:when>
            <xsl:when test="$Style='highlight'">
                <hi><xsl:apply-templates/></hi>
            </xsl:when>
            <xsl:when test="$Style='q'">
                <q>
                <xsl:choose>
                    <xsl:when test="starts-with(.,'&#x2018;')">
                        <xsl:value-of select="substring-before(substring-after(.,'&#x2018;'),'&#x2019;')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
                </q>
            </xsl:when>
            <xsl:when test="$Style='date'">
                <date>
                <xsl:apply-templates/>
                </date>
            </xsl:when>
            <xsl:when test="$Style='l'">
                <l>
                <xsl:apply-templates/>
                </l>
            </xsl:when>
            <xsl:when test="$Style='filespec'">
                <Filespec>
                <xsl:apply-templates/>
                </Filespec>
            </xsl:when>
            <xsl:when test="$Style='gi'">
                <gi>
                <xsl:apply-templates/>
                </gi>
            </xsl:when>
            <xsl:when test="$Style='code'">
                <Code>
                <xsl:apply-templates/>
                </Code>
            </xsl:when>
            <xsl:when test="$Style='input'">
                <Input>
                <xsl:apply-templates/>
                </Input>
            </xsl:when>
            <xsl:when test="$Style='internetlink'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="$Style='subscript'">
                <hi rend="sub"><xsl:apply-templates/></hi>
            </xsl:when>
            <xsl:when test="$Style='superscript'">
                <hi rend="sup"><xsl:apply-templates/></hi>
            </xsl:when>
            <xsl:when test="../text:h">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- <xsl:when test="normalize-space(.)=''"/>-->
                <xsl:when test="$Style='italic'">
                    <hi rend="italic"><xsl:apply-templates/></hi>
                </xsl:when>
                <xsl:when test="$Style='bold'">
                    <hi rend="bold"><xsl:apply-templates/></hi>
                </xsl:when>
                <xsl:when test="$Style='sup'">
                    <xsl:choose>
                        <xsl:when test="not(./text:note)">
                            <hi rend="sup"><xsl:apply-templates/></hi>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$Style='sub'">
                    <hi rend="sub"><xsl:apply-templates/></hi>
                </xsl:when>
                <xsl:when test="$Style='solid'">
                    <hi rend="underline"><xsl:apply-templates/></hi>
                </xsl:when>
                <xsl:when test="$Style='italic;bold'">
                    <hi rend="emphasis"><xsl:apply-templates/></hi>
                </xsl:when>

            <xsl:otherwise>
                <!-- <xsl:apply-templates/>
                <xsl:call-template name="applyStyle"/> TODO ? -->
                <xsl:choose>
                    <xsl:when test="contains(@text:style-name,'_')"> 
                        <xsl:variable name="rend">
                            <xsl:value-of select="substring-before(@text:style-name,'_')"/>  
                        </xsl:variable>
                        <xsl:variable name="rendition">
                            <xsl:value-of select="substring-after(@text:style-name,'_')"/>  
                        </xsl:variable>
                        <hi rend="{$rend}" rendition="#{$rendition}"><xsl:apply-templates/></hi>
                    </xsl:when>
                    <xsl:when test="starts-with(@text:style-name,'T')">
                        <xsl:variable name="rendition">
                            <xsl:value-of select="@text:style-name"/>  
                        </xsl:variable>
                        <hi rendition="#{$rendition}"><xsl:apply-templates/></hi>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="rend">
                            <xsl:value-of select="@text:style-name"/>  
                        </xsl:variable>
                        <hi rend="{$rend}"><xsl:apply-templates/></hi>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- tables -->
    <xsl:template match="table:table">
        <table rend="frame">
        <xsl:if test="@table:name and not(@table:name = 'local-table')">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@table:name"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="following-sibling::text:p[@text:style-name='table']">
            <head>
                <xsl:value-of select="following-sibling::text:p[@text:style-name='table']"/>
            </head>
        </xsl:if>
        <xsl:call-template name="generictable"/>
        </table>
    </xsl:template>

    <xsl:template name="generictable">
        <xsl:variable name="cells" select="count(descendant::table:table-cell)"/>
        <xsl:variable name="rows">
            <xsl:value-of select="count(descendant::table:table-row) "/>
        </xsl:variable>
        <xsl:variable name="cols">
            <xsl:value-of select="$cells div $rows"/>
        </xsl:variable>
        <xsl:variable name="numcols">
        <xsl:choose>
            <xsl:when test="child::table:table-column/@table:number-columns-repeated">
                <xsl:value-of select="number(table:table-column/@table:number-columns-repeated+1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$cols"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template name="colspec">
        <xsl:param name="left"/>
        <xsl:if test="number($left &lt; ( table:table-column/@table:number-columns-repeated +2)  )">
        <colspec>
            <xsl:attribute name="colnum">
                <xsl:value-of select="$left"/>
            </xsl:attribute>
            <xsl:attribute name="colname">
                <xsl:text>c</xsl:text>
                <xsl:value-of select="$left"/>
            </xsl:attribute>
        </colspec>
        <xsl:call-template name="colspec">
            <xsl:with-param name="left" select="$left+1"/>
        </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="table:table-column">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="table:table-header-rows">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="table:table-header-rows/table:table-row">
        <row role="label">
        <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="table:table/table:table-row">
        <row>
        <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="table:table-cell/text:h">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="table:table-cell">
        <cell>
        <xsl:if test="@table:number-columns-spanned &gt;'1'">
            <xsl:attribute name="cols">
            <xsl:value-of select="@table:number-columns-spanned"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="text:h">
            <xsl:attribute name="role">label</xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
        </cell>
    </xsl:template>


    <!-- notes -->

        <!-- we don't need the footnotesymbol style 
        <xsl:template match="text:span[contains(@text:style-name,'footnotesymbol')]">
            <xsl:apply-templates/>
        </xsl:template>
        -->
    <xsl:template match="text:note-citation"/>

    <xsl:template match="text:note-body">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:note">
    <note>
        <xsl:choose>
            <xsl:when test="@text:note-class='endnote'">
                <xsl:attribute name="place">end</xsl:attribute>
            </xsl:when>
            <xsl:when test="@text:note-class='footnote'">
                <xsl:attribute name="place">foot</xsl:attribute>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="text:note-citation">
            <xsl:attribute name="n">
                <xsl:value-of select="text:note-citation"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
    </note>
    </xsl:template>

    <!-- sxw notes -->
    <xsl:template match="text:footnote-citation"/>
    <xsl:template match="text:footnote-body">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="text:footnote">
    <note>
        <xsl:choose>
            <xsl:when test="@text:note-class='endnote'">
                <xsl:attribute name="place">end</xsl:attribute>
            </xsl:when>
            <xsl:when test="@text:note-class='footnote'">
                <xsl:attribute name="place">foot</xsl:attribute>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="text:footnote-citation">
            <xsl:attribute name="n">
                <xsl:value-of select="text:note-citation"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
    </note>
    </xsl:template>


    <!-- images -->
    <xsl:template match="draw:frame/draw:image[@xlink:href]">
        <xsl:if test="not(starts-with(@xlink:href, './Object'))"> <!-- TODO OLE -->
            <graphic>
            <xsl:attribute name="url">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            </graphic>
        </xsl:if>
    </xsl:template>

    <!-- drawing -->
    <xsl:template match="draw:plugin">
        <ptr target="{@xlink:href}"/>
    </xsl:template>

    <xsl:template match="draw:text-box">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="draw:frame">
        <xsl:choose>
        <xsl:when test="ancestor::draw:frame">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <figure>
            <xsl:apply-templates/>
            </figure>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="draw:image">
        <xsl:choose>
        <xsl:when test="ancestor::draw:text-box">
            <xsl:call-template name="findGraphic"/>
        </xsl:when>
        <xsl:when test="parent::text:p[@text:style-name='Mediaobject']">
            <figure>
            <xsl:call-template name="findGraphic"/>
            <head>
                <xsl:value-of select="."/>
            </head>
            </figure>
        </xsl:when>
        <xsl:otherwise>
            <figure>
            <xsl:call-template name="findGraphic"/>
            </figure>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="findGraphic">
        <xsl:choose>
        <xsl:when test="office:binary-data">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:when test="@xlink:href">
            <graphic>
            <xsl:attribute name="url">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            </graphic>
        </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="office:binary-data">    
        <binaryObject mimeType="image/jpg">
            <xsl:value-of select="."/>
        </binaryObject>
    </xsl:template>


    <!-- linking -->
    <xsl:template match="text:a">
        <xsl:choose>
        <xsl:when test="starts-with(@xlink:href,'mailto:')">
            <xsl:choose>
            <xsl:when test=".=@xlink:href">
                <ptr target="{substring-after(@xlink:href,'mailto:')}"/>
            </xsl:when>
            <xsl:otherwise>
                <ref target="{@xlink:href}"><xsl:apply-templates/></ref>
            </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="contains(@xlink:href,'://')">
            <xsl:choose>
            <xsl:when test=".=@xlink:href">
                <ptr target="{@xlink:href}"/>
            </xsl:when>
            <xsl:otherwise>
                <ref target="{@xlink:href}"><xsl:apply-templates/></ref>
            </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="not(contains(@xlink:href,'#'))">
            <ref target="{@xlink:href}"><xsl:apply-templates/></ref>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="linkvar" select="@xlink:href"/>
            <xsl:choose>
            <xsl:when test=".=$linkvar">
                <ptr target="{$linkvar}"/>
            </xsl:when>
            <xsl:otherwise>
                <ref target="{$linkvar}"><xsl:apply-templates/></ref>
            </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- break -->
    <xsl:template match="text:soft-page-break">
        <xsl:if test="not(parent::text:span[@text:style-name='l'])">
        <pb/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text:line-break">
        <xsl:if test="not(parent::text:span[@text:style-name='l'])">
        <lb/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text:tab">
        <xsl:text>  </xsl:text>
    </xsl:template>


  <xsl:template match="text:reference-ref">
    <ptr target="#id_{@text:ref-name}"/>
  </xsl:template>

  <xsl:template match="text:reference-mark-start"/>

  <xsl:template match="text:reference-mark-end"/>

  <xsl:template match="comment">
    <xsl:comment>
      <xsl:value-of select="."/>
    </xsl:comment>
  </xsl:template>

  <xsl:template match="text:user-index-mark">
    <index indexName="{@text:index-name}">
      <term><xsl:value-of select="@text:string-value"/></term>
    </index>
  </xsl:template>

  <xsl:template match="text:alphabetical-index-mark">
    <index>
      <xsl:if test="@text:id">
	<xsl:attribute name="xml:id">
	  <xsl:value-of select="@text:id"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:choose>
	<xsl:when test="@text:key1">
	  <term><xsl:value-of select="@text:key1"/></term>
	  <index>
	    <term><xsl:value-of select="@text:string-value"/></term>
	  </index>
	</xsl:when>
	<xsl:otherwise>
	  <term><xsl:value-of select="@text:string-value"/></term>
	</xsl:otherwise>
      </xsl:choose>
    </index>
  </xsl:template>

  <xsl:template match="text:alphabetical-index">
    <index>
      <xsl:apply-templates select="text:index-body"/>
    </index>
  </xsl:template>

  <xsl:template match="text:index-body">
    <xsl:for-each select="text:p[@text:style-name = 'Index 1']">
      <index>
        <term><xsl:value-of select="."/></term>
        <xsl:if test="key('secondary_children', generate-id())">
          <index>
	    <term><xsl:value-of select="key('secondary_children', generate-id())"/></term>
	  </index>
        </xsl:if>
      </index>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="text:bookmark-ref">
    <ref target="#id_{@text:ref-name}" type="{@text:reference-format}"><xsl:apply-templates/></ref>
  </xsl:template>

  <xsl:template match="text:bookmark-start">
    <anchor type="bookmark-start">
      <xsl:attribute name="xml:id">
	<xsl:text>id_</xsl:text>
	<xsl:value-of select="@text:name"/>
      </xsl:attribute>
    </anchor>
  </xsl:template>

  <xsl:template match="text:bookmark-end">
    <anchor type="bookmark-end">
      <xsl:attribute name="corresp">
	<xsl:text>#id_</xsl:text>
	<xsl:value-of select="@text:name"/>
      </xsl:attribute>
    </anchor>
  </xsl:template>

  <xsl:template match="text:bookmark">
    <anchor>
      <xsl:attribute name="xml:id">
	<xsl:text>id_</xsl:text>
	<xsl:value-of select="@text:name"/>
      </xsl:attribute>
    </anchor>
  </xsl:template>



<!--
These seem to have no obvious translation
-->
    <xsl:template match="text:endnotes-configuration"/>
    <xsl:template match="text:file-name"/>
    <xsl:template match="text:footnotes-configuration"/>
    <xsl:template match="text:linenumbering-configuration"/>
    <xsl:template match="text:list-level-style-bullet"/>
    <xsl:template match="text:list-level-style-number"/>
    <xsl:template match="text:list-style"/>
    <xsl:template match="text:outline-level-style"/>
    <xsl:template match="text:outline-style"/>
    <xsl:template match="text:s"/>

    <xsl:template match="text:*"> 
        [[[UNTRANSLATED <xsl:value-of select="name(.)"/>: <xsl:apply-templates/>]]]
    </xsl:template>

    <!-- sections of the OO format we don't need at present -->
    <xsl:template match="office:automatic-styles"/>
    <xsl:template match="office:font-decls"/>
    <xsl:template match="office:meta"/>
    <xsl:template match="office:script"/>
    <xsl:template match="office:settings"/>
    <xsl:template match="office:styles"/>
    <xsl:template match="style:*"/>

    <xsl:template match="dc:*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="meta:creation-date">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="meta:editing-cycles"/>
    <xsl:template match="meta:editing-duration"/>
    <xsl:template match="meta:generator"/>
    <xsl:template match="meta:user-defined"/>

    <!--
    <xsl:template match="text()">
    <xsl:apply-templates select="normalize-space(.)"/>
    </xsl:template>
    -->

    <xsl:template match="text:section">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:sequence-decl">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:sequence-decls">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:sequence">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:section-source"/>

    <xsl:template name="stars">
        <xsl:param name="n"/>
        <xsl:if test="$n &gt;0">
            <xsl:text>*</xsl:text>
            <xsl:call-template name="stars">
            <xsl:with-param name="n">
                <xsl:value-of select="$n - 1"/>
            </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text:change|text:changed-region|text:change-end|text:change-start">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:table-of-content"/>
    <xsl:template match="text:index-entry-chapter"/>
    <xsl:template match="text:index-entry-page-number"/>
    <xsl:template match="text:index-entry-tab-stop"/>
    <xsl:template match="text:index-entry-text"/>
    <xsl:template match="text:index-title-template"/>
    <xsl:template match="text:table-of-content-entry-template"/>
    <xsl:template match="text:table-of-content-source"/>

</xsl:stylesheet>