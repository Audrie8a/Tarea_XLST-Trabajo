<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="urn:my-scripts" version="1.0" exclude-result-prefixes="msxsl user">
     
     
     <xsl:output indent="no" method="text"/>
     <xsl:variable name="espacio" ><xsl:text>  </xsl:text></xsl:variable>
     <xsl:variable name="texto"><xsl:text></xsl:text></xsl:variable>
     <xsl:variable name='newline'><xsl:text>
  
  

  </xsl:text></xsl:variable>
     
     <xsl:template match ="/">    
          
          <xsl:apply-templates />
          
          
     </xsl:template>
     
     <xsl:template match="f" >
          
          <f>
               
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
                    <var>
                         <xsl:value-of select="concat('_',$node)"/>
                    </var>
                    
               </xsl:when>
               <xsl:when test="name($node)='const' ">
                    <const>
                         <xsl:value-of select="concat('_',$node)"/> 
                    </const>
                    
               </xsl:when>
               <xsl:when test="name($node)='plus'">
                    <plus>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                         
                    </plus>
               </xsl:when>
               <xsl:when test="name($node)='subs'">
                    <subs>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                         
                    </subs>
                    
               </xsl:when>
               <xsl:when test="name($node)='times'">
                    <times>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                    </times>
               </xsl:when>
               <xsl:when test="name($node)='div'">
                    <div>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                    </div>
               </xsl:when>
               <xsl:when test="'power'">
                    <power>
                         <!-- Recorrer por la izq -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[1]"/>
                         </xsl:call-template>
                         
                         
                         <!-- Recorrer por la der -->
                         <xsl:call-template name="function">
                              <xsl:with-param name="node" select="$node/child::*[2]"/>
                         </xsl:call-template>
                    </power>
               </xsl:when>
          </xsl:choose>
          
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
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
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
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </xsl:when>
          
     <!--L: var    R: ninguna  -->
          <xsl:otherwise>       
          <plus>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:apply-templates select="./child::*[2]"/>
          </plus>
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
          <xsl:apply-templates select="./child::*[1]"/>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          </plus>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <plus>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:apply-templates select="./child::*[2]"/>
          </plus>
          
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
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <subs>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          </subs>
          
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          <subs>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <xsl:apply-templates select="./child::*[2]"/>
          </subs>
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          <subs>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          <xsl:apply-templates select="./child::*[2]"/>
          </subs>
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
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          
          <times>
          <xsl:apply-templates select="./child::*[2]"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          </times>
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <times>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          <var>
          <xsl:value-of select="concat($texto,$left)"/>
          </var>
          </times>
          
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          
          <plus>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <times>
          <xsl:apply-templates select="./child::*[2]"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          </times>
          </plus>
          
          </xsl:otherwise>
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <times>
          <xsl:apply-templates select="./child::*[1]"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          </times>
          
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->
          <xsl:when test="number($right)!=$right and string-length($right)=1">
          <plus>
          <times>
          <xsl:apply-templates select="./child::*[1]"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>          
          </times>
          
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          </plus>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <plus>
          <times>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node" select="./child::*[2]"/>
          </xsl:call-template>
          </times>
          <times>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node" select="./child::*[1]"/>
          </xsl:call-template>
          </times>
          
          </plus>
          
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
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <subs>
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          <div>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <power>
          <var>
          <xsl:value-of select="concat($texto,$right)"/>
          </var>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </power>
          </div>
          </subs>
          
          
          </xsl:when>
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
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <div>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/></const>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          </div>
          
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          <div>
          <subs>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <times>
          <xsl:apply-templates select="./child::*[2]"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          </times>
          </subs>
          <power>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </power>
          </div>
          
          
          </xsl:otherwise>
          
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <div>
          <times>
          <xsl:apply-templates select="./child::*[1]"/>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          </times>
          <power>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </power>
          </div>
          </xsl:when>
          
          
     <!-- L: ninguna    R: var -->
          <xsl:when test="number($right)!=$right and string-length($right)=1">
          <div>
          <subs>
          <times>
          <xsl:apply-templates select="./child::*[1]"/>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>
          </times>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          </subs>
          <power>
          <var>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </var>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </power>
          </div>
          </xsl:when>
     <!-- L: ninguna    R: ninguna -->
          <xsl:otherwise>
          
          <div>
          <plus>
          <times>
          <xsl:apply-templates select="./child::*[1]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          </times>
          
          <times>
          <xsl:apply-templates select="./child::*[2]"/>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[1]"/>
          </xsl:call-template>
          </times>
          </plus>          
          <power>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </power>
          </div>
          
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
          <const>
          <xsl:value-of select="concat($texto,'_0')"/>
          </const>
          </xsl:when>
          
     <!-- L: cte    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <times>
          <ln>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>       
          </ln>
          <power>
          <const>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </const>
          <var>
          <xsl:value-of select="concat($texto,$right)"/>
          </var>
          </power>
          </times>
          </xsl:when>
     <!-- L: cte    R: ninguna -->
          <xsl:otherwise>
          <const>
          <xsl:value-of select="concat($texto,'_0000')"/>
          </const>
          
          </xsl:otherwise>
          </xsl:choose>   
          </xsl:when>
          
          <xsl:when test="number($left)!=$left and string-length($left)=1">
          
          <xsl:choose>
     <!-- L: var    R: cte -->
          <xsl:when test="number($right)=$right">
          <times>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <power>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <const>
          <xsl:value-of select="concat($texto,'_')"/>
          <xsl:value-of select="number($right)-1"/>
          </const>
          </power>
          </times>
          
          </xsl:when>
          
     <!-- L: var    R: var -->
          <xsl:when  test="number($right)!=$right and string-length($right)=1">
          <times>
          <power>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          </power>
          <plus>
          <ln>
          <var>
          <xsl:value-of select="concat($texto,'_',$left)"/>
          </var>
          </ln>
          <const>
          <xsl:value-of select="concat($texto,'_1')"/>
          </const>
          </plus>
          </const>
          <const>
          <xsl:value-of select="concat($texto,'_2')"/>
          </const>
          </xsl:when>
     <!-- L: var    R: ninguna -->
          <xsl:otherwise>
          <const>
          <xsl:value-of select="concat($texto,'_0000')"/>
          </const>
          
          </xsl:otherwise>
          </xsl:choose> 
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
     <!-- L: ninguna    R: cte -->
          <xsl:when test="number($right)=$right">
          <times>
          <times>
          <const>
          <xsl:value-of select="concat($texto,'_',$right)"/>
          </const>
          <power>
          <xsl:call-template name="function">
          <xsl:with-param name="node"  select="./child::*[2]"/>
          </xsl:call-template>
          <const>
          <xsl:value-of select="concat($texto,'_')"/>
          <xsl:value-of select="number($right)-1"/>
          </const>
          </power>
          </times>
          <xsl:apply-templates select="./child::*[1]"/>
          </times>
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
          <xsl:value-of select="concat($texto,.)"/>
          </xsl:template>
          
          
     <!-- VARIABLE--------------------------------------------------------------------------------------------- -->
          <xsl:template match="var" >
          <xsl:value-of select="concat($texto,.)"/>
          </xsl:template>
          
          </xsl:stylesheet>
