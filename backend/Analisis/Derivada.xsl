<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output indent="no" method="text"/>
  
  <xsl:variable name='newline'><xsl:text>

  </xsl:text></xsl:variable>
  
  <xsl:template match ="/">
    
    
    <xsl:variable name="respuesta" >
      <xsl:call-template name="derivada">
        <xsl:with-param name="node" select="f//*" />
        <xsl:with-param name="index" select="1"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:value-of select="$respuesta"/>
    
    
  </xsl:template>
  
  
  
  <xsl:template name="derivada" >
    <xsl:param name="node" />
    <xsl:param name="index"/>
    
    <xsl:choose>
      <xsl:when test="name($node)='const'">
        <xsl:value-of select="$node"/>
        
        <xsl:choose>
          <xsl:when test="name($node/following-sibling::*)=''">
            <!-- <xsl:text>       Bro Izq: </xsl:text>
                 <xsl:value-of select="name($node/preceding-sibling::*)"/> -->
             </xsl:when>
          <xsl:when test="name($node/following-sibling::*)='' and name($node/preceding-sibling::*)=''">
            <!-- <xsl:text>       Hijo_Unico </xsl:text> -->
          </xsl:when>
          <xsl:otherwise>
            
          </xsl:otherwise>
        </xsl:choose>
        
      </xsl:when>
      
      <xsl:when test="name($node)='var'">
        <xsl:value-of select="$node"/>
        
        <xsl:choose>
          <xsl:when test="name($node/following-sibling::*)=''">
            <!-- <xsl:text>       Bro Izq: </xsl:text>
                 <xsl:value-of select="name($node/preceding-sibling::*)"/> -->
             </xsl:when>
          <xsl:when test="name($node/following-sibling::*)='' and name($node/preceding-sibling::*)=''">
            <!-- <xsl:text>       Hijo_Unico </xsl:text> -->
          </xsl:when>
          <xsl:otherwise>
            
          </xsl:otherwise>
        </xsl:choose>
        
      </xsl:when>
    </xsl:choose>
    
    
    <!-- Recorrer por la izq -->
    <xsl:if test="$index !=count(f//*)">
      <xsl:call-template name="derivada">
        <xsl:with-param name="node" select="$node/child::*[1]"/>
        <xsl:with-param name="index" as="" select="$index+1"/>
      </xsl:call-template>
      
      <xsl:if test="$node/child::*[1]">
        <xsl:choose>
          <xsl:when test="name($node)='plus'">
            <xsl:value-of select="'+''"/>
          </xsl:when>
          <xsl:when test="name($node)='times'">
            <xsl:value-of select="'*'"/>
          </xsl:when>
          
          <xsl:when test="name($node)='power'">
            <xsl:value-of select="'^''"/>
          </xsl:when>
          
          <xsl:when test="name($node)='div'">
            <xsl:value-of select="/"/>
          </xsl:when>
          
          <xsl:when test="name($node)='subs'">
            <xsl:value-of select="'-'"/>
          </xsl:when>
          
        </xsl:choose>
      </xsl:if>
      
      
      
      <!-- Recorrer por la derecha -->
      <xsl:call-template name="derivada">
        <xsl:with-param name="node" select="$node/child::*[2]"/>
        <xsl:with-param name="index" as="" select="$index+1"/>
      </xsl:call-template>           
      
      
    </xsl:template>
    
    
    
  </xsl:stylesheet>
