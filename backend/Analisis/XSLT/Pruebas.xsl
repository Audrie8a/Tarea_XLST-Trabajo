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
    
    
    <xsl:otherwise>
      
      <xsl:value-of select="concat($texto,'_Hola')"/>
      
    </xsl:otherwise>
    
    
    
    <!-- L: cte    R: ninguna -->
    <xsl:otherwise>
      <subs>
        <const>
          <xsl:value-of select="concat($texto,'_0')"/>
        </const>
        <div>
          <times>
            <xsl:apply-templates select="./child::*[2]"/>
            <const>
              <xsl:value-of select="concat($texto,'_',$left)"/>
            </const>
          </times>
          <power>
            <xsl:call-template name="function">
              <xsl:with-param name="node"  select="./child::*[2]"/>
            </xsl:call-template>
            <const>
              <xsl:value-of select="concat($texto,'_2')"/>
            </const>
          </power>
        </div>
      </power>
      
      
    </xsl:otherwise>
    
    
    
    
    <xsl:otherwise>
      <xsl:choose>
        <!-- L: ninguna    R: cte -->
        <xsl:when test="number($right)=$right">
          <xsl:apply-templates select="./child::*[1]"/>
        </xsl:when>
        
        
        <!-- L: ninguna    R: var -->
        <xsl:when test="number($right)!=$right and string-length($right)=1">
          <subs>
            <xsl:apply-templates select="./child::*[1]"/>
            <const>
              <xsl:value-of select="concat($texto,'_1')"/>
            </const>
          </subs>
        </xsl:when>
        <!-- L: ninguna    R: ninguna -->
        <xsl:otherwise>
          
          <subs>
            <xsl:apply-templates select="./child::*[1]"/>
            <xsl:apply-templates select="./child::*[2]"/>
          </subs>
          
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
    
    <xsl:value-of select="concat($texto,'_0000')"/>