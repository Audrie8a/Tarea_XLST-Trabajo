<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="urn:my-scripts" version="1.0" exclude-result-prefixes="msxsl user">
     
     
     <xsl:output indent="no" method="text"/>
     <xsl:variable name="espacio" ><xsl:text>  </xsl:text></xsl:variable>
     <xsl:variable name="texto"><xsl:text></xsl:text></xsl:variable>
     <xsl:variable name="tab" ><xsl:text>    </xsl:text></xsl:variable>
     <xsl:variable name='newline'><xsl:text>
     </xsl:text></xsl:variable>
     
     <xsl:template match ="/">    
          
          <xsl:apply-templates />
          
          
     </xsl:template>
     
     <xsl:template match="f" >
          
          <f>
               <xsl:value-of select="$newline"/>
               <xsl:apply-templates />
          </f>
          
          
          
     </xsl:template>
     
     <xsl:template match="pluss" >
          <xsl:variable name="left">
               <xsl:apply-templates select="./child::*[1]"/>
          </xsl:variable>
          <xsl:value-of select="number($left)-1"/>
     </xsl:template>
     
     <xsl:template name="function" >
          <xsl:param name="node" />
          
          
          <xsl:choose>
               
               <xsl:when test="name($node)='var'">
                    <xsl:value-of select="$newline"/>
                    <var>
                         <xsl:value-of select="concat('_',$node)"/>
                    </var>
                    <xsl:value-of select="$newline"/>
                    
               </xsl:when>
               <xsl:when test="name($node)='const' ">
                    <xsl:value-of select="$newline"/>
                    <const>
                         <xsl:value-of select="concat('_',$node)"/> 
                    </const>
                    <xsl:value-of select="$newline"/>
                    
               </xsl:when>
               <xsl:when test="name($node)='plus'">
                    <plus>
                         <xsl:value-of select="concat($newline,$tab)"/>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                         
                    </plus>
                    <xsl:value-of select="$newline"/>
               </xsl:when>
               <xsl:when test="name($node)='subs'">
                    <subs>
                         <xsl:value-of select="concat($newline,$tab)"/>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                         
                    </subs>
                    <xsl:value-of select="$newline"/>
                    
               </xsl:when>
               <xsl:when test="name($node)='times'">
                    <times>
                         <xsl:value-of select="concat($newline,$tab)"/>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                    </times>
                    <xsl:value-of select="$newline"/>
               </xsl:when>
               <xsl:when test="name($node)='div'">
                    <div>
                         <xsl:value-of select="concat($newline,$tab)"/>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                    </div>
                    <xsl:value-of select="$newline"/>
               </xsl:when>
               <xsl:when test="'power'">
                    <power>
                         <xsl:value-of select="concat($newline,$tab)"/>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                    </power>
                    <xsl:value-of select="$newline"/>
               </xsl:when>
          </xsl:choose>
          <xsl:value-of select="$newline"/>
     </xsl:template>
     <!-- SUMA---------------------------------------------------------------------------------------------------- -->
          <xsl:template match="plus" >
          
          <xsl:variable name="left">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:variable>
          
          <xsl:variable name="right">
          <xsl:apply-templates select="./child::*[2]"/>
          </xsl:variable>
          
          
          
          <xsl:choose>
          
          <xsl:when test="number($left)=$left">       
          <xsl:choose>
     <!-- L: cte    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          <xsl:otherwise>
     <!--L: cte    R: ninguna  -->
          <xsl:apply-templates select="./child::*[2]"/>
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>    
          
          
          
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!--L: var    R: ninguna  -->
          <xsl:otherwise>       
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <xsl:apply-templates select="./child::*[2]"/>
          </plus>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          
          </xsl:choose> 
          </xsl:when>
          
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->
          <xsl:when test="number($right)!=$right and string-length($right)=1">
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </plus>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:apply-templates select="./child::*[2]"/>
          </plus>
          <xsl:value-of select="$newline"/>
          
          </xsl:otherwise>
          </xsl:choose>
          </xsl:otherwise>
          </xsl:choose>
          
          <xsl:value-of select="$newline"/>
          
          </xsl:template>
          
     <!-- RESTA-------------------------------------------------------------------------------------------------- -->
          <xsl:template match="subs" >
          <xsl:variable name="left">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:variable>
          
          <xsl:variable name="right">
          <xsl:apply-templates select="./child::*[2]"/>
          </xsl:variable>
          
          
          
          
          <xsl:choose>
          
          <xsl:when test="number($left)=$left">       
          <xsl:choose>
     <!-- L: cte    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </subs>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <xsl:apply-templates select="./child::*[2]"/>
          </subs>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <xsl:apply-templates select="./child::*[2]"/>
          </subs>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->
          <xsl:when test="number($right)!=$right and string-length($right)=1">
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </subs>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:apply-templates select="./child::*[2]"/>
          </subs>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          </xsl:choose>
          </xsl:otherwise>
          </xsl:choose>
          
          <xsl:value-of select="$newline"/>
          
          </xsl:template>
          
     <!-- MULTIPLICACION----------------------------------------------------------------------------------------- -->
          <xsl:template match="times" >
          <xsl:variable name="left">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:variable>
          
          <xsl:variable name="right">
          <xsl:apply-templates select="./child::*[2]"/>
          </xsl:variable>
          
          
          
          <xsl:choose>
          
          <xsl:when test="number($left)=$left">       
          <xsl:choose>
     <!-- L: cte    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <times>
          
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </plus>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->
          <xsl:when test="number($right)!=$right and string-length($right)=1">
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var> 
          <xsl:value-of select="$newline"/>         
          </times>
          <xsl:value-of select="$newline"/>
          
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          </plus>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node" select="./child::*[2]"/>
          </xsl:call-template>
          </times>
          <xsl:value-of select="$newline"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node" select="./child::*[1]"/>
          </xsl:call-template>
          </times>
          <xsl:value-of select="$newline"/>
          
          </plus>
          <xsl:value-of select="$newline"/>
          </xsl:otherwise>
          </xsl:choose>
          </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="$newline"/>
          
          </xsl:template>
          
     <!-- DIVISION----------------------------------------------------------------------------------------------- -->
          <xsl:template match="div" >
          <xsl:variable name="left">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:variable>
          
          <xsl:variable name="right">
          <xsl:apply-templates select="./child::*[2]"/>
          </xsl:variable>
          
          
          
          <xsl:choose>
          
          <xsl:when test="number($left)=$left">       
          <xsl:choose>
     <!-- L: cte    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          </subs>
          <xsl:value-of select="$newline"/>
          
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          
          
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/></const>
          <xsl:value-of select="$newline"/>
          <const>
          
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </subs>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          
          
          </xsl:otherwise>
          
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->
          <xsl:when test="number($right)!=$right and string-length($right)=1">
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          </subs>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <div>
          <xsl:value-of select="concat($newline,$tab)"/>
          <subs>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          </times>
          <xsl:value-of select="$newline"/>
          
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          </times>
          <xsl:value-of select="$newline"/>
          </subs>          
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </div>
          <xsl:value-of select="$newline"/>
          
          </xsl:otherwise>
          </xsl:choose>
          </xsl:otherwise>
          </xsl:choose>
          
          <xsl:value-of select="$newline"/>
          </xsl:template>
          
     <!-- POTENCIA---------------------------------------------------------------------------------------------- -->
          <xsl:template match="power" >
          <xsl:variable name="left">
          <xsl:apply-templates select="./child::*[1]"/>
          </xsl:variable>
          
          <xsl:variable name="right">
          <xsl:apply-templates select="./child::*[2]"/>
          </xsl:variable>
          
          
          
          
          <xsl:choose>
          
          <xsl:when test="number($left)=$left">       
          <xsl:choose>
     <!-- L: cte    R: cte -->
          <xsl:when test="number($right)=$right">
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <ln>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>   
          <xsl:value-of select="$newline"/>    
          </ln>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0000')"/>
          </const>
          <xsl:value-of select="$newline"/>
          
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_')"/>
          <xsl:value-of select="number($right)-1"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          <plus>
          <xsl:value-of select="concat($newline,$tab)"/>
          <ln>
          <xsl:value-of select="$newline"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <xsl:value-of select="$newline"/>
          </ln>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </plus>
          <xsl:value-of select="$newline"/>
          </const>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_0000')"/>
          </const>
          <xsl:value-of select="$newline"/>
          
          </xsl:otherwise>
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <times>
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <xsl:value-of select="$newline"/>
          <power>
          <xsl:value-of select="concat($newline,$tab)"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          <xsl:value-of select="$newline"/>
          <const>
          <xsl:value-of select="concat($texto,'_')"/>
          <xsl:value-of select="number($right)-1"/>
          </const>
          <xsl:value-of select="$newline"/>
          </power>
          <xsl:value-of select="$newline"/>
          </times>
          <xsl:value-of select="$newline"/>
          <xsl:apply-templates select="./child::*[1]"/>
          </times>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->          
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <xsl:value-of select="concat($texto,'_0000')"/>
          
          </xsl:otherwise>
          </xsl:choose>
          </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="$newline"/>
          
          </xsl:template>
          
     <!-- CONSTANTE--------------------------------------------------------------------------------------------- -->
          <xsl:template match="const" >
          <xsl:choose>
          <xsl:when test="name(./ancestor::*)='f' ">
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          <xsl:otherwise>
          <xsl:value-of select="concat($texto,.)"/>
          </xsl:otherwise>
          </xsl:choose>
          
          </xsl:template>
          
          
     <!-- VARIABLE--------------------------------------------------------------------------------------------- -->
          <xsl:template match="var" >
          
          <xsl:choose>
          <xsl:when test="name(./ancestor::*)='f' ">
          <xsl:value-of select="concat($newline,$tab)"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:value-of select="$newline"/>
          </xsl:when>
          <xsl:otherwise>
          <xsl:value-of select="concat($texto,.)"/>
          </xsl:otherwise>
          </xsl:choose>
          </xsl:template>
          
          </xsl:stylesheet>
