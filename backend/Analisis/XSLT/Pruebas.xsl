<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="urn:my-scripts" version="1.0" exclude-result-prefixes="msxsl user">
  
  
  <xsl:output indent="no" method="text"/>
  <xsl:variable name="espacio" ><xsl:text>  </xsl:text></xsl:variable>
  <xsl:variable name="texto"><xsl:text></xsl:text></xsl:variable>
  <xsl:variable name='newline'><xsl:text>
  
  

  </xsl:text></xsl:variable>
  
  <xsl:template match ="/">    
    
    <xsl:choose>
      <xsl:when test="">
        
      </xsl:when>
      <xsl:otherwise>
        
      </xsl:otherwise>
    </xsl:choose>
    
    
    <!-- L: var    R: ninguna -->
    <xsl:otherwise>
      <subs>
        <const>
          <xsl:value-of select="concat($texto,'_1')"/>
        </const>
        <xsl:apply-templates select="./child::*[2]"/>
      </subs>
    </xsl:otherwise>
    
    
    <!-- Recorrer por la izq -->
    <xsl:call-template name="function">
      <xsl:with-param name="node" select="$node/child::*[1]"/>
    </xsl:call-template>
    
    
    <!-- Recorrer por la der -->
    <xsl:call-template name="function">
      <xsl:with-param name="node" select="$node/child::*[2]"/>
    </xsl:call-template>
    
  </xsl:template>
  
  
</xsl:stylesheet>


<plus>
  <xsl:call-template name="function">
    <xsl:with-param name="node"  select="./child::*[1]"/>
  </xsl:call-template>
  <times>
    <xsl:value-of select="concat($texto,$right)"/>
    <var>
      <xsl:value-of select="concat($texto,'_',$left)"/>
    </var>
  </times>
</plus>

<!-- L: var    R: ninguna -->
<xsl:otherwise>
  
  <xsl:value-of select="concat($texto,'_Hola')"/>
  
</xsl:otherwise>