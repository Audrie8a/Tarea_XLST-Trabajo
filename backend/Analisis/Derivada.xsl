<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output indent="no" method="text"/>
  <xsl:variable name="espacio" ><xsl:text>  </xsl:text></xsl:variable>
  <xsl:variable name="texto"><xsl:text> </xsl:text></xsl:variable>
  <xsl:variable name='newline'><xsl:text>
  
  

  </xsl:text></xsl:variable>
  
  <xsl:template match ="/">
    
    
    <xsl:variable name="respuesta" >
      <xsl:call-template name="derivada">
        <xsl:with-param name="node" select="f//*" />
        <xsl:with-param name="index" select="1"/>
        <xsl:with-param name="limit" select="count(f//*)"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:value-of select="$respuesta"/>
    
    
  </xsl:template>
  
  
  
  <xsl:template name="derivada" >
    <xsl:param name="node" />
    <xsl:param name="index"/>
    <xsl:param name="limit"/>
    
    <xsl:text>Index</xsl:text>
    <xsl:value-of select="$index"/>
    <xsl:value-of select="$espacio"/>
    <xsl:value-of select="concat($texto,'Posición')"/>
    <xsl:value-of select="position()"/>
    <xsl:value-of select="$espacio"/>
    <xsl:value-of select="concat($texto, 'Etiqueta: ')"/>
    <xsl:value-of select="name($node)"/>
    
    <xsl:if test="name($node)='var' or name($node)='const'">
      <xsl:value-of select="concat($texto, 'Valor: ')"/>
      <xsl:value-of select="$node"/>
    </xsl:if>
    
    <xsl:value-of select="$newline"/>
    
    
    <!-- Recorrer por la izq -->
    <xsl:if test="$index !=$limit">
      <xsl:if test="name($node/child::*[1])!=''">
        <xsl:value-of select="concat($texto,'RECORRIDO POR LA IZQUIERDA!')"/>
        <xsl:value-of select="$newline"/>
        <xsl:call-template name="derivada">
          <xsl:with-param name="node" select="$node/child::*[1]"/>
          <xsl:with-param name="index" select="$index+1"/>
          <xsl:with-param name="limit" select="$limit"/>
        </xsl:call-template>
      </xsl:if>
      
      
      
      <!-- Recorrer por la izq -->
      <xsl:if test="$index !=$limit">
        <xsl:if test="name($node/child::*[2])!=''">
          <xsl:value-of select="concat($texto,'RECORRIDO POR LA DERECHA!')"/>
          <xsl:value-of select="$newline"/>
          <xsl:call-template name="derivada">
            <xsl:with-param name="node" select="$node/child::*[2]"/>
            <xsl:with-param name="index" select="$index+1"/>
            <xsl:with-param name="limit" select="$limit"/>
          </xsl:call-template>
        </xsl:if>
        
        
        
      </xsl:template>
      
      
      
    </xsl:stylesheet>
