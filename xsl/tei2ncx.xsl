<?xml version="1.0" encoding="UTF-8"?>
<!-- 
<h1>TEI » epub : toc.ncx (tei_ncx.xsl)</h1>

© 2012, <a href="http://www.algone.net/">Algone</a>, licence  <a href="http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html">CeCILL-C</a>/<a href="http://www.gnu.org/licenses/lgpl.html">LGPL</a>
<ul>
  <li>[FG] <a href="#" onmouseover="this.href='mailto'+'\x3A'+'glorieux'+'\x40'+'algone.net'">Frédéric Glorieux</a></li>
  <li>[VJ] <a href="#" onmouseover="this.href='mailto'+'\x3A'+'jolivet'+'\x40'+'algone.net'">Vincent Jolivet</a></li>
</ul>

-->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.daisy.org/z3986/2005/ncx/"
    xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
    exclude-result-prefixes="tei ncx"
    
    xmlns:exslt="http://exslt.org/common"
    extension-element-prefixes="exslt"
  >
  <xsl:import href="../../Transtei/common.xsl"/>
  <!-- ensure override on common -->
  <xsl:include href="epub.xsl"/>
  <xsl:output encoding="UTF-8" indent="yes" format-public="-//NISO//DTD ncx 2005-1//EN" format-system="http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"/>
  <!-- Comment profond aller ? -->
  
  <!-- Nom de l'xslt appelante -->
  <xsl:variable name="this">tei_ncx.xsl</xsl:variable>
  <xsl:template match="/">
    <ncx  version="2005-1">
      <head>
        <meta name="dtb:uid" content="{$identifier}"/>
        <!--
        <meta name="dtb:depth" content="{$depth}"/>
        <xsl:param name="depth">
    <xsl:choose>
      <xsl:when test="/*/tei:teiHeader/tei:encodingDesc/tei:tagsDecl/tei:rendition[@xml:id='toc-depth']">
        <xsl:value-of select="/*/tei:teiHeader/tei:encodingDesc/tei:tagsDecl/tei:rendition[@xml:id='toc-depth']/@n"/>
      </xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div1/tei:div2/tei:div3">3</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div1/tei:div2">2</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div1">1</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div/tei:div/tei:div/tei:div/tei:div/tei:div">6</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div/tei:div/tei:div/tei:div/tei:div">5</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div/tei:div/tei:div/tei:div">4</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div/tei:div/tei:div">3</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div/tei:div">2</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:div">1</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:group/tei:group/tei:group/tei:group/tei:group/tei:group">6</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:group/tei:group/tei:group/tei:group/tei:group">5</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:group/tei:group/tei:group/tei:group">4</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:group/tei:group/tei:group">3</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:group/tei:group">2</xsl:when>
      <xsl:when test="/*/tei:text/tei:body/tei:group">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
        -->
        <meta name="dtb:totalPageCount" content="0"/>
        <meta name="dtb:maxPageNumber" content="0"/>
      </head>
      <docTitle>
        <text>
          <xsl:value-of select="$doctitle"/>
        </text>
      </docTitle>
      <xsl:variable name="navMap">
        <navMap>
          <!-- Cover ? -->
          <xsl:choose>
            <xsl:when test="$cover">
              <navPoint id="cover" playOrder="1">
                <navLabel>
                  <text>
                    <xsl:call-template name="message">
                      <xsl:with-param name="id">cover</xsl:with-param>
                    </xsl:call-template>
                  </text>
                </navLabel>
                <content src="cover{$_html}"/>
              </navPoint>
              <navPoint id="titlePage" playOrder="2">
                <navLabel>
                  <text>
                    <xsl:call-template name="message">
                      <xsl:with-param name="id">titlePage</xsl:with-param>
                    </xsl:call-template>
                  </text>
                </navLabel>
                <content src="titlePage{$_html}"/>
              </navPoint>
            </xsl:when>
            <xsl:otherwise>
              <navPoint id="titlePage" playOrder="1">
                <navLabel>
                  <text>
                    <xsl:call-template name="message">
                      <xsl:with-param name="id">titlePage</xsl:with-param>
                    </xsl:call-template>
                  </text>
                </navLabel>
                <content src="titlePage{$_html}"/>
              </navPoint>
            </xsl:otherwise>
          </xsl:choose>
          <navPoint id="toc">
            <navLabel>
              <text>
                <xsl:call-template name="message">
                  <xsl:with-param name="id">toc</xsl:with-param>
                </xsl:call-template>
              </text>
            </navLabel>
            <content src="toc{$_html}"/>
          </navPoint>
          <xsl:apply-templates select="/*/tei:text/*/*" mode="ncx">
            
          </xsl:apply-templates>
          <xsl:if test="$fnpage != ''">
            <navPoint id="{$fnpage}">
              <navLabel>
                <text>
                  <xsl:call-template name="message">
                    <xsl:with-param name="id">notes</xsl:with-param>
                  </xsl:call-template>
                </text>
              </navLabel>
              <content src="{$fnpage}{$_html}"/>
            </navPoint>
          </xsl:if>
        </navMap>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="function-available('exslt:node-set')">
          <!-- renumber navPoint -->
          <xsl:apply-templates select="exslt:node-set($navMap)" mode="playOrder"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="$navMap"/>
        </xsl:otherwise>
      </xsl:choose>
    </ncx>
  </xsl:template>
  <!-- Mode entré dans la nav, par défaut, arrêter -->
  <xsl:template match="*" mode="ncx"/>
  <xsl:template match="tei:TEICorpus" mode="ncx">
    <xsl:param name="depth"/>
    <xsl:apply-templates select="*" mode="ncx">
      <xsl:with-param name="depth" select="$depth"/>
    </xsl:apply-templates> 
  </xsl:template>
  <xsl:template match="tei:TEI | tei:TEI.2" mode="ncx">
    <xsl:param name="depth"/>
    <xsl:apply-templates select="tei:text" mode="ncx">
      <xsl:with-param name="depth" select="$depth"/>
    </xsl:apply-templates> 
  </xsl:template>
  <!-- traverser -->
  <xsl:template match="/*/tei:text" mode="ncx">
    <xsl:param name="depth"/>
    <xsl:apply-templates select="* " mode="ncx">
      <xsl:with-param name="depth" select="$depth"/>
    </xsl:apply-templates> 
  </xsl:template>
  <!-- entry is always created  -->
  <xsl:template match="/*/tei:text/tei:front/tei:titlePage" mode="ncx"/>
  <xsl:template match="
    /*/tei:text/tei:front/*[self::tei:argument | self::tei:castList | self::tei:epilogue | self::tei:performance | self::tei:prologue | self::tei:set]
  | /*/tei:text/tei:back/*[self::tei:argument | self::tei:castList | self::tei:epilogue | self::tei:performance | self::tei:prologue | self::tei:set]
    " mode="ncx">
    <xsl:param name="depth"/>
    <xsl:call-template name="navPoint">
      <xsl:with-param name="depth" select="$depth - 1"/>
    </xsl:call-template>
  </xsl:template> 
  <!-- Sections, split candidates -->
  <xsl:template mode="ncx" match="
    tei:body | tei:front | tei:back | tei:group |
    tei:div | tei:div0 | tei:div1 | tei:div2 | tei:div3 | tei:div4 | tei:div5 | tei:div6 | tei:div7 
">  
    <xsl:param name="depth"/>
    <xsl:call-template name="navPoint">
      <xsl:with-param name="depth" select="$depth - 1"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Créer un point de nav -->
  <xsl:template name="navPoint">
    <xsl:param name="depth"/>
    <navPoint>
      <xsl:attribute name="id">
        <xsl:call-template name="id"/>
      </xsl:attribute>
      <xsl:attribute name="playOrder">
        <xsl:variable name="playOrder">
          <xsl:number level="any" count="tei:group | tei:div | tei:div0 | tei:div1 | tei:div2 | tei:div3 | tei:div4 | tei:div5 | tei:div6 | tei:div7 | /*/tei:text/tei:front/tei:argument "/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$cover">
            <xsl:value-of select="$playOrder + 2"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- +1 for auto titlePage -->
            <xsl:value-of select="$playOrder + 1"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <navLabel>
        <text>
          <xsl:variable name="title">
            <xsl:call-template name="title"/>
          </xsl:variable>
          <xsl:value-of select="normalize-space($title)"/>
        </text>
      </navLabel>
      <content>
        <xsl:attribute name="src">
          <xsl:call-template name="href"/>
        </xsl:attribute>
      </content>
      <xsl:if test="$depth != 0">
        <xsl:apply-templates select="tei:div | tei:div0 | tei:div1 | tei:div2 | tei:div3 | tei:div4 | tei:div5 | tei:div6 | tei:div7 | tei:argument[parent::tei:front]" mode="ncx">
          <xsl:with-param name="depth" select="$depth"/>
        </xsl:apply-templates>
      </xsl:if>
    </navPoint>
  </xsl:template>
 

  <!-- Renuméroter la navigation -->
  <xsl:template match="node() | @*" mode="playOrder">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="playOrder"/>
    </xsl:copy>
  </xsl:template>
  <!-- Always compute a sequential value for playOrder -->
  <xsl:template match="ncx:navPoint" mode="playOrder">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="playOrder"><xsl:number count="ncx:navPoint" level="any"/></xsl:attribute>
      <xsl:apply-templates mode="playOrder"/>
    </xsl:copy>
  </xsl:template>
</xsl:transform>