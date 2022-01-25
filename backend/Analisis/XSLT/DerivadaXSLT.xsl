<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output indent="no" method="text"/>
  <xsl:variable name="espacio" ><xsl:text>  </xsl:text></xsl:variable>
  <xsl:variable name="texto"><xsl:text></xsl:text></xsl:variable>
  <xsl:variable name='newline'><xsl:text>
  
  

  </xsl:text></xsl:variable>
  
  <xsl:template match ="/">
    
    
    <xsl:variable name="respuesta" >
      <xsl:call-template name="derivada">
        <xsl:with-param name="node" select="f//*" />
        <xsl:with-param name="index" select="1"/>
        <xsl:with-param name="limit" select="count(child::f//*)"/>
      </xsl:call-template>
    </xsl:variable>
    
    
    <xsl:value-of select="$respuesta"/>
  </xsl:template>
  
  
  
  <xsl:template name="derivada" >
    <xsl:param name="node" />
    <xsl:param name="index"/>
    <xsl:param name="limit"/>
    
    <xsl:choose>
      
      <xsl:when test="name($node)='var'">
        <xsl:value-of select="$node"/>          
      </xsl:when>
      <xsl:when test="name($node)='const' ">
        <xsl:value-of select="$node"/>          
      </xsl:when>
      
    </xsl:choose>
    
    <xsl:variable name="left">
      <!-- Recorrer por la izq -->
      <xsl:if test="name($node)!='const'">
        <xsl:if test="name($node)!='var'">
          <xsl:call-template name="derivada">
            <xsl:with-param name="node" select="$node/child::*[1]"/>
            <xsl:with-param name="index" select="$index+1"/>
            <xsl:with-param name="limit" select="$limit"/>
          </xsl:call-template>
        </xsl:if>
        
      </xsl:if>
    </xsl:variable>
    
    
    <xsl:variable name="right" >
      
      <!-- Recorrer por la der -->
      <xsl:if test="name($node)!='const'">
        <xsl:if test="name($node)!='var'">
          <xsl:call-template name="derivada">
            <xsl:with-param name="node" select="$node/child::*[2]"/>
            <xsl:with-param name="index" select="$index+1"/>
            <xsl:with-param name="limit" select="$limit"/>
          </xsl:call-template>
        </xsl:if>        
      </xsl:if>
      
    </xsl:variable>
    
    <xsl:if test="name($node)!='const'">
      <xsl:if test="name($node)!='var'">
        <xsl:value-of select="concat($newline,'Ronda',$index,': ')"/>
        <xsl:value-of select="concat($left,name($node),$right,$newline)"/>
      </xsl:if>
      
    </xsl:if>
    
    
    
    
  </xsl:template>
  
  
  
</xsl:stylesheet>
