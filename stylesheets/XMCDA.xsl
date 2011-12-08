<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xmcda="http://www.decision-deck.org/2009/XMCDA-2.0.0">
	
<xsl:output method="html" encoding="ISO-8859-1" />

<xsl:key name="critID" match="performance" use="criterionID"/>

<xsl:template match="/">
	<html>	
		<head>
			<title>XMCDA Scheme</title>
                        <link REL="stylesheet" TYPE="text/css" HREF="cssStyle.css"/>
		</head>
		<body>
			<div class="XMCDA">
				<xsl:apply-templates/>
			</div>
		</body>
	</html>
</xsl:template>


<xsl:template match="projectReference">
	<div class="projectReference">
		<div class="title"><xsl:value-of select="title" /></div>
		<div class="subTitle"><xsl:value-of select="subTitle" /></div>
		<div class="subSubTitle"><xsl:value-of select="subSubTitle" /></div>
		<xsl:if test="version">
			<div class="subSubTitle">Version <xsl:value-of select="version"/></div>
		</xsl:if>
		<xsl:for-each select="author">
			<div class="author"><xsl:value-of select="." /></div>
		</xsl:for-each>
	</div>
</xsl:template>


<xsl:template match="methodMessages">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Method messages</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<xsl:for-each select="./*">
			<xsl:choose>
				<xsl:when test="self::logMessage">
					<xsl:choose>
						<xsl:when test="@mcdaConcept">
							<xsl:value-of select="@mcdaConcept"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="@name">
									<xsl:value-of select="@name"/>
								</xsl:when>
								<xsl:otherwise>
									LOG
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>	
					 : <xsl:value-of select="text"/><br/>
					<xsl:apply-templates select="description"/>
				</xsl:when>
				<xsl:when test="self::errorMessage">
					<font COLOR="red">
					<xsl:choose>
						<xsl:when test="@mcdaConcept">
							<xsl:value-of select="@mcdaConcept"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="@name">
									<xsl:value-of select="@name"/>
								</xsl:when>
								<xsl:otherwise>
									ERROR
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					</font> : <xsl:value-of select="text"/><br/>
					<xsl:apply-templates select="description"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="@mcdaConcept">
							<xsl:value-of select="@mcdaConcept"/> :<xsl:text> </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="@name">
									<xsl:value-of select="@name"/> :<xsl:text> </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="text"/><br/>
					<xsl:apply-templates select="description"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</div>
</xsl:template>


<xsl:template match="methodParameters">
	<div class="bloc">
		<div class="classTitle">
		<xsl:choose>
			<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
			<xsl:otherwise>Method parameters</xsl:otherwise>
		</xsl:choose>
		</div>
		<div class="methodParameters">
			<xsl:if test="@name">
					<div class="classSubTitle"><xsl:value-of select="@name"/></div>
			</xsl:if>
			<ul>
				<xsl:for-each select="./approach">
					<li>Approach: <value-of select="."/></li>
				</xsl:for-each>
				<xsl:for-each select="./problematique">
					<li>Problematique: <value-of select="."/></li>
				</xsl:for-each>
				<xsl:for-each select="./methodology">
					<li>Methodoly: <value-of select="."/></li>
				</xsl:for-each>
				<xsl:for-each select="./parameters">
					<li><B><xsl:value-of select="@name"/></B><UL>
						<xsl:for-each select="./parameter">
						<li><xsl:value-of select="@name"/> : <xsl:value-of select="." /></li>
					</xsl:for-each>
					</UL></li>
				</xsl:for-each>
				<xsl:for-each select="./parameter">
					<li><B><xsl:value-of select="@name"/></B> = <xsl:value-of select="." /></li>
				</xsl:for-each>
			</ul>
		</div>
	</div>
</xsl:template>


<xsl:template match="description">
	<div class="description">
		<xsl:for-each select="./*">
			<xsl:choose>
				<xsl:when test="self::title"><div class="itemDescription">Title : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::subTitle"><div class="itemDescription">Subtitle : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::subSubTitle"><div class="itemDescription">Subsubtitle : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::user"><div class="itemDescription">User : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::author"><div class="itemDescription">Author : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::version"><div class="itemDescription">Version : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::creationDate"><div class="itemDescription">Creation : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::lastModificationDate"><div class="itemDescription">Last modification : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::shortName"><div class="itemDescription">Short name : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::comment"><div class="itemDescription">Comment : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::abstract"><div class="itemDescription">Abstract : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::keywords"><div class="itemDescription">Keywords : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::bibliography"><div class="itemDescription">Bibliography : <xsl:value-of select="."/></div></xsl:when>
				<xsl:when test="self::stakeholders"><div class="itemDescription">Stakeholders : <xsl:value-of select="."/></div></xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</div>
</xsl:template>


<xsl:template match="alternatives">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:if test="@name">
				<div class="classSubTitle"><xsl:value-of select="@name"/></div>
			</xsl:if>
			<xsl:apply-templates select="description"/>
			<ul>
				<xsl:for-each select="alternative">
					<li>
						Id : <B><xsl:value-of select="@id"/></B><br/>
						<xsl:choose>
							<xsl:when test="@name">
								Name : <xsl:value-of select="@name"/><br/>
							</xsl:when>
							<xsl:when test="active">
								<I>Active : <xsl:value-of select="active"/></I><br/>
							</xsl:when>
						</xsl:choose>
						<xsl:apply-templates select="description"/>
					</li>
				</xsl:for-each>
			</ul>
		</div>				
	</div>
</xsl:template>


<xsl:template match="alternativesSet">
	{
		<xsl:variable name="nbElt" select="count(element)"/>
		<xsl:for-each select="element">
			<xsl:value-of select="alternativeID"/>
			<xsl:if test="position() &lt; $nbElt">, </xsl:if>
		</xsl:for-each>
		<xsl:text> </xsl:text>
	}
</xsl:template>


<xsl:template match="alternativesSets">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives Sets</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:apply-templates select="description"/>
			<ul>
				<li>
					<xsl:apply-templates select="alternativesSet"/>
				</li>
			</ul>
		</div>
	</div>
</xsl:template>	


<xsl:template match="attributes">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attributes</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:if test="@name">
				<div class="classSubTitle"><xsl:value-of select="@name"/></div>
			</xsl:if>
			<xsl:apply-templates select="description"/>
			<ul>
				<xsl:for-each select="attribute">
					<li>
						Id : <B><xsl:value-of select="@id"/></B><br/>
						<xsl:choose>
							<xsl:when test="@name">
								Name : <xsl:value-of select="@name"/><br/>
							</xsl:when>
							<xsl:when test="active">
								<I>Active : <xsl:value-of select="active"/></I><br/>
							</xsl:when>
							<xsl:when test="scale">
								<I>Scale : <xsl:apply-templates select="scale"/></I><br/>
							</xsl:when>
						</xsl:choose>
						<xsl:apply-templates select="description"/>
					</li>
				</xsl:for-each>
			</ul>
		</div>				
	</div>
</xsl:template>


<xsl:template match="attributesSet">
	{
		<xsl:variable name="nbElt" select="count(element)"/>
		<xsl:for-each select="element">
			<xsl:value-of select="AttributeID"/>
			<xsl:if test="position() &lt; $nbElt">, </xsl:if>
		</xsl:for-each>
		<xsl:text> </xsl:text>
	}
</xsl:template>


<xsl:template match="attributesSets">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attributes sets</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:apply-templates select="description"/>
			<ul>
				<li>
					<xsl:apply-templates select="attributesSet"/>
				</li>
			</ul>
		</div>
	</div>
</xsl:template>


<xsl:template match="criteria">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criteria</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:if test="@name">
				<div class="classSubTitle"><xsl:value-of select="@name"/></div>
			</xsl:if>
			<xsl:apply-templates select="description"/>
			<ul>
				<xsl:for-each select="criterion">
					<li>
						Id : <B><xsl:value-of select="@id"/></B><br/>
						<xsl:choose>
							<xsl:when test="@name">
								Name : <xsl:value-of select="@name"/><br/>
							</xsl:when>
						</xsl:choose>
						<xsl:apply-templates select="description"/>
						<xsl:choose>
							<xsl:when test="scale">
								Scale : <xsl:apply-templates select="scale"/><br/>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="active">
								<I>Active : <xsl:value-of select="active"/></I><br/>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="thresholds">
								<xsl:choose>
									<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
									<xsl:otherwise>Thresholds</xsl:otherwise>
								</xsl:choose>: <ul>
								<xsl:for-each select="thresholds/threshold">
									<li style="margin-bottom: 0px;">
										<xsl:choose>
											<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
											<xsl:otherwise>threshold</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="constant">
												: <xsl:value-of select="constant"/>
											</xsl:when>
											<xsl:when test="linear">
												: <xsl:value-of select="linear/slope"/> x + <xsl:value-of select="linear/intercept"/>
											</xsl:when>
										</xsl:choose>
									</li>
								</xsl:for-each>
								</ul>
							</xsl:when>
						</xsl:choose>
						<xsl:apply-templates select="criterionFunction"/>
					</li>
				</xsl:for-each>
			</ul>
		</div>
	</div>
</xsl:template>
		

<xsl:template match="criteriaSet">
	{
		<xsl:variable name="nbElt" select="count(element)"/>
		<xsl:for-each select="element">
			<xsl:value-of select="criterionID"/>
			<xsl:if test="position() &lt; $nbElt">, </xsl:if>
		</xsl:for-each>
		<xsl:text> </xsl:text>
	}
</xsl:template>	


<xsl:template match="criteriaSets">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criteria sets</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:apply-templates select="description"/>
			<ul>
				<li>
					<xsl:apply-templates select="criteriaSet"/>
				</li>
			</ul>
		</div>
	</div>
</xsl:template>


<xsl:template match="categories">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:if test="@name">
				<div class="classSubTitle"><xsl:value-of select="@name"/></div>
			</xsl:if>
			<xsl:apply-templates select="description"/>
			<ul>
				<xsl:for-each select="category">
					<li><B><xsl:value-of select="@name"/></B>: <xsl:value-of select="@id"/>
					<xsl:apply-templates select="description"/></li>
				</xsl:for-each>
			</ul>
		</div>
	</div>
</xsl:template>


<xsl:template match="categoriesSet">
	{
		<xsl:variable name="nbElt" select="count(element)"/>
		<xsl:for-each select="element">
			<xsl:value-of select="categoryID"/>
			<xsl:if test="position() &lt; $nbElt">, </xsl:if>
		</xsl:for-each>
		<xsl:text> </xsl:text>
	}
</xsl:template>


<xsl:template match="categoriesSets">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories sets</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="sousbloc">
			<xsl:apply-templates select="description"/>
			<ul>
				<li>
					<xsl:apply-templates select="categoriesSet"/>
				</li>
			</ul>
		</div>
	</div>

</xsl:template>


<xsl:template match="performanceTable">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Performance table</xsl:otherwise>
			</xsl:choose>
		</div>
		
		<xsl:apply-templates select="description"/>
			
			
		<xsl:variable name="numTable" select="position()"/>
		<xsl:choose>
			<xsl:when test="@id"><div class="classSubTitle"><xsl:value-of select="@id"/></div></xsl:when>
		</xsl:choose>
		
		<xsl:variable name="listCrit" select="alternativePerformances/performance/criterionID[not(.=following::criterionID)]"/>
		
		<table cellspacing='1'>
			<tr>
				<td></td>
				<xsl:for-each select="$listCrit">
					<td class="header"><xsl:value-of select="."/></td>
				</xsl:for-each>
			</tr>
			<xsl:for-each select="alternativePerformances/alternativeID[not(.=following::alternativeID)]">
				<xsl:variable name="altID" select="."/>
				<tr>
					<td class="header"><xsl:value-of select="$altID"/></td>
					<xsl:for-each select="$listCrit">
						<xsl:variable name="critID" select="."/>
						<td><xsl:apply-templates select="../../../alternativePerformances[alternativeID=$altID]/performance[criterionID=$critID]/value"/>
						</td>
					</xsl:for-each>

				</tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="alternativesCriteriaValues">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives criteria values</xsl:otherwise>
			</xsl:choose>
		</div>
		
		<xsl:apply-templates select="description"/>
			
			
		<xsl:variable name="numTable" select="position()"/>
		<xsl:choose>
			<xsl:when test="@id"><div class="classSubTitle"><xsl:value-of select="@id"/></div></xsl:when>
		</xsl:choose>
		
		<xsl:apply-templates select="description"/>
		
		<xsl:variable name="listCrit" select="alternativeCriteriaValue/criterionValue/criterionID[not(.=following::criterionID)]"/>
		<table cellspacing='1'>
			<tr>
				<td></td>
				<xsl:for-each select="$listCrit">
					<td class="header"><xsl:value-of select="."/></td>
				</xsl:for-each>
			</tr>
			<xsl:for-each select="alternativeCriteriaValue/alternativeID[not(.=following::alternativeID)]">
				<xsl:variable name="altID" select="."/>
				<tr>
					<td class="header"><xsl:value-of select="$altID"/></td>
					<xsl:for-each select="$listCrit">
						<xsl:variable name="critID" select="."/>
						<td><xsl:apply-templates select="../../../alternativeCriteriaValue[alternativeID=$altID]/criterionValue[criterionID=$critID]/value"/>
						</td>
					</xsl:for-each>

				</tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="hierarchy">
	<xsl:value-of select="."/>
</xsl:template>


<!-- CRITERIA RELATED -->


<xsl:template match="criterionValue">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criterion value</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="@name">
			<div class="classSubTitle"><xsl:value-of select="@name"/></div>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="criterionID"><xsl:value-of select="criterionID"/></xsl:when>
			<xsl:when test="criteriaSetID"><xsl:value-of select="criteriaSetID"/></xsl:when>
			<xsl:when test="criteriaSet"><xsl:apply-templates select="criteriaSet"/></xsl:when>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="value"/><br/>
	</div>
</xsl:template>


<xsl:template match="criteriaValues">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criteria values</xsl:otherwise>
			</xsl:choose>
		</div>
		<table cellspacing='1'>
		<xsl:for-each select="criterionValue">
			<tr>
				<td>
					<xsl:choose>
						<xsl:when test="criterionID"><xsl:value-of select="criterionID"/></xsl:when>
						<xsl:when test="criteriaSetID"><xsl:value-of select="criteriaSetID"/></xsl:when>
						<xsl:when test="criteriaSet"><xsl:apply-templates select="criteriaSet"/></xsl:when>
					</xsl:choose>
				</td>
				<td align="char" char=".">
					<xsl:apply-templates select="value"/>
				</td>
			</tr>
		</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="criteriaComparisons">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criteria comparisons</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<ul>
			<xsl:for-each select="./pairs">
				<xsl:for-each select="./pair">
				<li>
				<xsl:choose>
					<xsl:when test="initial/criterionID"><xsl:value-of select="./initial/criterionID"/></xsl:when>
					<xsl:when test="initial/criteriaSetID"><xsl:value-of select="./initial/criteriaSetID"/></xsl:when>
					<xsl:when test="initial/criteriaSet"><xsl:apply-templates select="./initial/criteriaSet"/> </xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="../../comparisonType='geq'">
						>=
					</xsl:when>
					<xsl:when test="../../comparisonType='eq'">
						=
					</xsl:when>
					<xsl:when test="../../comparisonType='leq'">
						&lt;=
					</xsl:when>
					<xsl:when test="../../comparisonType='neq'">
						!=
					</xsl:when>
					<xsl:when test="../../comparisonType='gtr'">
						>
					</xsl:when>
					<xsl:when test="../../comparisonType='less'">
						&lt;
					</xsl:when>	
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../../comparisonType">
								<xsl:text> </xsl:text><xsl:value-of select="../../comparisonType"/><xsl:text> </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text> </xsl:text>R<xsl:text> </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="terminal/criterionID"><xsl:value-of select="./terminal/criterionID"/></xsl:when>
					<xsl:when test="terminal/criteriaSetID"><xsl:value-of select="./terminal/criteriaSetID"/></xsl:when>
					<xsl:when test="terminal/criteriaSet"><xsl:apply-templates select="./terminal/criteriaSet"/> </xsl:when>
				</xsl:choose>
				<xsl:text> </xsl:text> (<xsl:apply-templates select="value"/>)
				</li>
				</xsl:for-each>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="criteriaLinearConstraints">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criteria linear constraints</xsl:otherwise>
			</xsl:choose>
		</div>
		<ul>
			<xsl:for-each select="constraint">
				<li>
					<xsl:for-each select="element">
						<xsl:if test="coefficient &gt; 0">+</xsl:if>
						<xsl:value-of select="coefficient"/>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="criterionID"><xsl:value-of select="criterionID"/></xsl:when>
							<xsl:when test="criteriaSetID"><xsl:value-of select="criteriaSetID"/></xsl:when>
							<xsl:when test="criteriaSet"><xsl:apply-templates select="criteriaSet"/></xsl:when>
							<xsl:when test="variable"><xsl:value-of select="variable/@id"/></xsl:when>
						</xsl:choose>
						<xsl:text> </xsl:text>
					</xsl:for-each>
					<xsl:choose>
						<xsl:when test="operator='geq'">>=</xsl:when>
						<xsl:when test="operator='eq'">=</xsl:when>
						<xsl:when test="operator='leq'">&lt;=</xsl:when>	
						<xsl:otherwise>?</xsl:otherwise>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="rhs"/>
					<xsl:if test="./value">(
						<xsl:if test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/> :</xsl:if>
						<xsl:apply-templates select="value"/> )
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="criteriaMatrix">
<!-- Pour le moment, on suppose les données données dans l'ordre-->
<!-- On suppose aussi que c'est le même ordre sur lignes et colonnes et qu'en plus, on a toutes les valeurs...-->
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Criteria matrix</xsl:otherwise>
			</xsl:choose>
			<xsl:text> </xsl:text><xsl:apply-templates select="valuation"/>
		</div>
		<xsl:apply-templates select="description"/>
		<table>
			<tr>
				<td><xsl:text> </xsl:text></td>
				<xsl:for-each select="./row">
					<td class="header">
						<xsl:choose>
							<xsl:when test="./criterionID"><xsl:value-of select="./criterionID"/></xsl:when>
							<xsl:when test="./criteriaSetID"><xsl:value-of select="./criteriaSetID"/></xsl:when>
							<xsl:when test="./criteriaSet"><xsl:apply-templates select="./criteriaSet"/></xsl:when>
						</xsl:choose>
					</td>
				</xsl:for-each>
			</tr>
			<xsl:for-each select="./row">
				<tr>
					<td class="header">
						<xsl:choose>
							<xsl:when test="./criterionID"><xsl:value-of select="./criterionID"/></xsl:when>
							<xsl:when test="./criteriaSetID"><xsl:value-of select="./criteriaSetID"/></xsl:when>
							<xsl:when test="./criteriaSet"><xsl:apply-templates select="./criteriaSet"/></xsl:when>
						</xsl:choose>
					</td>
					<xsl:for-each select="./column">
						<td><xsl:apply-templates select="value"/></td>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>


<!-- ATTRIBUTES RELATED -->


<xsl:template match="attributeValue">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attribute value</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="@name">
			<div class="classSubTitle"><xsl:value-of select="@name"/></div>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="attributeID"><xsl:value-of select="attributeID"/></xsl:when>
			<xsl:when test="attributesSetID"><xsl:value-of select="attributesSetID"/></xsl:when>
			<xsl:when test="attributesSet"><xsl:apply-templates select="attributesSet"/></xsl:when>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="value"/><br/>
	</div>
</xsl:template>


<xsl:template match="attributesValues">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attributes values</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<table cellspacing='1'>
			<xsl:for-each select="attributeValue">
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="attributeID"><xsl:value-of select="attributeID"/></xsl:when>
							<xsl:when test="attributesSetID"><xsl:value-of select="attributesSetID"/></xsl:when>
							<xsl:when test="attributesSet"><xsl:apply-templates select="attributesSet"/></xsl:when>
						</xsl:choose>
					</td>
					<td align="char" char=".">
						<xsl:apply-templates select="value"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="attributesComparisons">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attributes comparisons</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<xsl:apply-templates select="valuation"/>
		<ul>
		<xsl:for-each select="./pairs">
			<xsl:for-each select="./pair">
			<li>
			<xsl:choose>
				<xsl:when test="initial/attributeID"><xsl:value-of select="./initial/attributeID"/></xsl:when>
				<xsl:when test="initial/attributesSetID"><xsl:value-of select="./initial/attributesSetID"/></xsl:when>
				<xsl:when test="initial/attributesSet"><xsl:apply-templates select="attributesSet"/> </xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="../../comparisonType='geq'">>=</xsl:when>
				<xsl:when test="../../comparisonType='eq'">=</xsl:when>
				<xsl:when test="../../comparisonType='leq'">&lt;=</xsl:when>
				<xsl:when test="../../comparisonType='neq'">!=</xsl:when>
				<xsl:when test="../../comparisonType='gtr'">></xsl:when>
				<xsl:when test="../../comparisonType='less'">&lt;</xsl:when>	
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../../comparisonType">
							<xsl:text> </xsl:text><xsl:value-of select="../../comparisonType"/><xsl:text> </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> </xsl:text>R<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="terminal/attributeID"><xsl:value-of select="./terminal/attributeID"/></xsl:when>
				<xsl:when test="terminal/attributesSetID"><xsl:value-of select="./terminal/attributesSetID"/></xsl:when>
				<xsl:when test="terminal/attributesSet"><xsl:apply-templates select="attributesSet"/></xsl:when>
			</xsl:choose>
			<xsl:text> </xsl:text> (<xsl:apply-templates select="value"/>)
			</li>
			</xsl:for-each>
		</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="attributesLinearConstraints">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attributes linear constraints</xsl:otherwise>
			</xsl:choose>
		</div>
		<ul>
			<xsl:for-each select="constraint">
				<li>
					<xsl:for-each select="element">
						<xsl:if test="coefficient &gt; 0">+</xsl:if>
						<xsl:value-of select="coefficient"/>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="attributeID"><xsl:value-of select="attributeID"/> </xsl:when>
							<xsl:when test="attributesSetID"> <xsl:value-of select="attributesSetID"/> </xsl:when>
							<xsl:when test="attributesSet"> <xsl:apply-templates select="attributesSet"/> </xsl:when>
						</xsl:choose>
						<xsl:text> </xsl:text>
					</xsl:for-each>
					<xsl:choose>
						<xsl:when test="operator='geq'">>=</xsl:when>
						<xsl:when test="operator='eq'">=</xsl:when>
						<xsl:when test="operator='leq'">&lt;=</xsl:when>	
						<xsl:otherwise>?</xsl:otherwise>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="rhs"/>
					<xsl:if test="./value">(
						<xsl:if test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/> :</xsl:if>
						<xsl:apply-templates select="value"/> )
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="attributesMatrix">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Attributes matrix</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:value-of select="."/>
	</div>
</xsl:template>


<!-- ALTERNATIVES RELATED -->


<xsl:template match="alternativeValue">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternative value</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="@name">
			<div class="classSubTitle"><xsl:value-of select="@name"/></div>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="alternativeID"><xsl:value-of select="alternativeID"/></xsl:when>
			<xsl:when test="alternativesSetID"><xsl:value-of select="alternativesSetID"/></xsl:when>
			<xsl:when test="alternativesSet"><xsl:apply-templates select="alternativesSet"/></xsl:when>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="value"/><br/>
		<xsl:for-each select="values">
			<xsl:for-each select="value">
				<xsl:choose>
					<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise>value</xsl:otherwise>
				</xsl:choose>
				:
				<xsl:apply-templates select="."/><xsl:text> | </xsl:text>
			</xsl:for-each>
			<br/>
		</xsl:for-each>
	</div>
</xsl:template>


<xsl:template match="alternativesValues">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives values</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<table cellspacing='1'>
			<xsl:for-each select="alternativeValue">
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="alternativeID"><xsl:value-of select="alternativeID"/></xsl:when>
							<xsl:when test="alternativesSetID"><xsl:value-of select="alternativesSetID"/></xsl:when>
							<xsl:when test="alternativesSet"><xsl:apply-templates select="alternativesSet"/></xsl:when>
						</xsl:choose>
					</td>
					<td align="char" char=".">
						<xsl:apply-templates select="value"/>
						<xsl:for-each select="values">
							<xsl:for-each select="value">
								<xsl:choose>
									<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
									<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
									<xsl:otherwise>value</xsl:otherwise>
								</xsl:choose>
								:
								<xsl:apply-templates select="."/><xsl:text> | </xsl:text>
							</xsl:for-each>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="alternativesComparisons">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives comparisons</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<xsl:apply-templates select="valuation"/>
		<ul>
		<xsl:for-each select="./pairs">
			<xsl:for-each select="./pair">
			<li>
			<xsl:choose>
				<xsl:when test="initial/alternativeID"><xsl:value-of select="./initial/alternativeID"/></xsl:when>
				<xsl:when test="initial/alternativesSetID"><xsl:value-of select="./initial/alternativesSetID"/></xsl:when>
				<xsl:when test="initial/alternativesSet"><xsl:apply-templates select="alternativesSet"/> </xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="../../comparisonType='geq'">>=</xsl:when>
				<xsl:when test="../../comparisonType='eq'">=</xsl:when>
				<xsl:when test="../../comparisonType='leq'">&lt;=</xsl:when>
				<xsl:when test="../../comparisonType='neq'">!=</xsl:when>
				<xsl:when test="../../comparisonType='gtr'">></xsl:when>
				<xsl:when test="../../comparisonType='less'">&lt;</xsl:when>	
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../../comparisonType">
							<xsl:text> </xsl:text><xsl:value-of select="../../comparisonType"/><xsl:text> </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> </xsl:text>R<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="terminal/alternativeID"><xsl:value-of select="./terminal/alternativeID"/></xsl:when>
				<xsl:when test="terminal/alternativesSetID"><xsl:value-of select="./terminal/alternativesSetID"/></xsl:when>
				<xsl:when test="terminal/alternativesSet"><xsl:apply-templates select="alternativesSet"/></xsl:when>
			</xsl:choose>
			<xsl:text> </xsl:text> (
			<xsl:choose>
				<xsl:when test="value"><xsl:apply-templates select="value"/></xsl:when>
				<xsl:when test="values">
					<xsl:text>&#160;&#160;</xsl:text>
					<xsl:for-each select="./values/value">
						<xsl:choose>
							<xsl:when test="@name"><xsl:value-of select="@name"/>:</xsl:when>
							<xsl:when test="@id"><xsl:value-of select="@id"/>:</xsl:when>
							<xsl:otherwise>val:</xsl:otherwise>
						</xsl:choose>
						<xsl:apply-templates select="."/><xsl:text>&#160;&#160;</xsl:text>					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
			
			)
			</li>
			</xsl:for-each>
		</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="alternativesLinearConstraints">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives linear constraints</xsl:otherwise>
			</xsl:choose>
		</div>
		<ul>
			<xsl:for-each select="constraint">
				<li>
					<xsl:for-each select="element">
						<xsl:if test="coefficient &gt; 0">+</xsl:if>
						<xsl:value-of select="coefficient"/>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="alternativeID"><xsl:value-of select="alternativeID"/> </xsl:when>
							<xsl:when test="alternativesSetID"> <xsl:value-of select="alternativesSetID"/> </xsl:when>
							<xsl:when test="alternativesSet"> <xsl:apply-templates select="alternativesSet"/> </xsl:when>
						</xsl:choose>
						<xsl:text> </xsl:text>
					</xsl:for-each>
					<xsl:choose>
						<xsl:when test="operator='geq'">>=</xsl:when>
						<xsl:when test="operator='eq'">=</xsl:when>
						<xsl:when test="operator='leq'">&lt;=</xsl:when>	
						<xsl:otherwise>?</xsl:otherwise>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="rhs"/>
					<xsl:if test="./value">(
						<xsl:if test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/> :</xsl:if>
						<xsl:apply-templates select="value"/> )
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="alternativesMatrix">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives matrix</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:value-of select="."/>
	</div>
</xsl:template>


<!-- CATEGORIES RELATED -->


<xsl:template match="categoriesProfiles">
	<div class="bloc">
		<div class="classTitle">
				<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories profiles</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<ul><xsl:apply-templates select="categoryProfile"/></ul>
	</div>
</xsl:template>


<xsl:template match="categoryProfile">
	<li>
		Category profile id : <xsl:value-of select="./alternativeID"/><br/>
		<xsl:apply-templates select="description"/>
		<xsl:choose>
			<xsl:when test="central">central profile on category <xsl:value-of select="central/categoryID"/></xsl:when>
			<xsl:when test="limits">
				limit profile between <xsl:value-of select="limits/lowerCategory"/> (lower category) and <xsl:value-of select="limits/upperCategory"/> (upper category)
			</xsl:when>
		</xsl:choose>
	</li>
</xsl:template>


<xsl:template match="categoriesContents">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories contents</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:value-of select="."/>
	</div>
</xsl:template>


<xsl:template match="alternativesAffectations">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Alternatives affectations</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="description"/>
		</div>
		<ul><xsl:apply-templates select="alternativeAffectation"/></ul>
	</div>
</xsl:template>


<xsl:template match="alternativeAffectation">
	<li>
		<xsl:choose>
			<xsl:when test="./alternativeID"><xsl:value-of select="./alternativeID"/></xsl:when>
			<xsl:when test="./alternativesSetID"><xsl:value-of select="./alternativesSetID"/></xsl:when>
			<xsl:when test="./alternativesSet"> alternatives set <xsl:apply-templates select="alternativesSet"/> </xsl:when>
		</xsl:choose>
		 -> 
		 <xsl:choose>
			<xsl:when test="./categoryID"><xsl:value-of select="./categoryID"/></xsl:when>
			<xsl:when test="./categoriesSetID"><xsl:value-of select="./alternativesSetID"/></xsl:when>
			<xsl:when test="./categoriesSet"> categories set <xsl:apply-templates select="categoriesSet"/> </xsl:when>
			<xsl:when test="./categoriesInterval"><xsl:apply-templates select="categoriesInterval"/></xsl:when>
		</xsl:choose>
		<xsl:if test="./value">(
			<xsl:if test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/> :</xsl:if>
			<xsl:apply-templates select="value"/> )
		</xsl:if>
		<xsl:apply-templates select="description"/>
	</li>
</xsl:template>


<xsl:template match="categoryValue">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Category value</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="@name">
			<div class="classSubTitle"><xsl:value-of select="@name"/></div>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="categoryID"><xsl:value-of select="categoryID"/></xsl:when>
			<xsl:when test="categorieSetID"><xsl:value-of select="categoriesSetID"/></xsl:when>
			<xsl:when test="categoriesSet"><xsl:apply-templates select="categoriesSet"/></xsl:when>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="value"/><br/>
	</div>
</xsl:template>


<xsl:template match="categoriesValues">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories values</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<table cellspacing='1'>
			<xsl:for-each select="categoryValue">
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="categoryID"><xsl:value-of select="categoryID"/></xsl:when>
							<xsl:when test="categoriesSetID"><xsl:value-of select="categoriesSetID"/></xsl:when>
							<xsl:when test="categoriesSet"><xsl:apply-templates select="categoriesSet"/></xsl:when>
						</xsl:choose>
					</td>
					<td align="char" char=".">
						<xsl:apply-templates select="value"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>


<xsl:template match="categoriesComparisons">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories comparisons</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="description"/>
		<xsl:apply-templates select="valuation"/>
		<ul>
		<xsl:for-each select="./pairs">
			<xsl:for-each select="./pair">
			<li>
			<xsl:choose>
				<xsl:when test="initial/categoryID"><xsl:value-of select="./initial/categoryID"/></xsl:when>
				<xsl:when test="initial/categoriesSetID"><xsl:value-of select="./initial/categoriesSetID"/></xsl:when>
				<xsl:when test="initial/categoriesSet"><xsl:apply-templates select="categoriesSet"/> </xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="../../comparisonType='geq'">>=</xsl:when>
				<xsl:when test="../../comparisonType='eq'">=</xsl:when>
				<xsl:when test="../../comparisonType='leq'">&lt;=</xsl:when>
				<xsl:when test="../../comparisonType='neq'">!=</xsl:when>
				<xsl:when test="../../comparisonType='gtr'">></xsl:when>
				<xsl:when test="../../comparisonType='less'">&lt;</xsl:when>	
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../../comparisonType">
							<xsl:text> </xsl:text><xsl:value-of select="../../comparisonType"/><xsl:text> </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> </xsl:text>R<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="terminal/categoryID"><xsl:value-of select="./terminal/categoryID"/></xsl:when>
				<xsl:when test="terminal/categoriesSetID"><xsl:value-of select="./terminal/categoriesSetID"/></xsl:when>
				<xsl:when test="terminal/categoriesSet"><xsl:apply-templates select="categoriesSet"/></xsl:when>
			</xsl:choose>
			<xsl:text> </xsl:text> (<xsl:apply-templates select="value"/>)
			</li>
			</xsl:for-each>
		</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="categoriesLinearConstraints">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories linear constraints</xsl:otherwise>
			</xsl:choose>
		</div>
		<ul>
			<xsl:for-each select="constraint">
				<li>
					<xsl:for-each select="element">
						<xsl:if test="coefficient &gt; 0">+</xsl:if>
						<xsl:value-of select="coefficient"/>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="categoryID"><xsl:value-of select="categoryID"/></xsl:when>
							<xsl:when test="categoriesSetID"><xsl:value-of select="categoriesSetID"/></xsl:when>
							<xsl:when test="categoriesSet"><xsl:apply-templates select="categoriesSet"/></xsl:when>
						</xsl:choose>
						<xsl:text> </xsl:text>
					</xsl:for-each>
					<xsl:choose>
						<xsl:when test="operator='geq'">>=</xsl:when>
						<xsl:when test="operator='eq'">=</xsl:when>
						<xsl:when test="operator='leq'">&lt;=</xsl:when>	
						<xsl:otherwise>?</xsl:otherwise>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="rhs"/>
					<xsl:if test="./value">(
						<xsl:if test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/> :</xsl:if>
						<xsl:apply-templates select="value"/> )
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="categoriesMatrix">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories matrix</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:value-of select="."/>
	</div>
</xsl:template>


<!-- OTHER TEMPLATES -->


<xsl:template match="criteriaScales">
	<div class="classSubTitle">Criteria scales : <xsl:value-of select="@name"/></div>
	<xsl:apply-templates select="description"/>
	<xsl:apply-templates select="criterionScale"/>
</xsl:template>


<xsl:template match="criterionScale">
	<div class="classSubSubTitle"><xsl:value-of select="@name"/></div>
	<xsl:apply-templates/>
</xsl:template>


<xsl:template match="criterionFunction">
	Criterion function <xsl:value-of select="criterionID"/> : <xsl:apply-templates/>
</xsl:template>


<xsl:template match="categoriesInterval">
	[<xsl:value-of select="lowerBound"/> ; <xsl:value-of select="upperBound"/>]
</xsl:template>


<xsl:template match="categoriesRanks">
	<div class="bloc">
		<div class="classTitle">
			<xsl:choose>
				<xsl:when test="@mcdaConcept"><xsl:value-of select="@mcdaConcept"/></xsl:when>
				<xsl:otherwise>Categories ranks</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:value-of select="."/>
	</div>
</xsl:template>


<xsl:template match="scale">
	<xsl:choose>
		<xsl:when test="quantitative">
			[ <xsl:value-of select="./quantitative/minimum"/> ; <xsl:value-of select="./quantitative/maximum"/> ]
			<xsl:if test="quantitative/preferenceDirection">(<xsl:value-of select="quantitative/preferenceDirection"/>)</xsl:if>
		</xsl:when>
		<xsl:when test="qualitative">
			[
			<xsl:for-each select="./qualitative/rankedLabel">
				<xsl:value-of select="label"/>(<xsl:value-of select="rank"/>) 
			</xsl:for-each>
			]
		</xsl:when>
		<xsl:when test="nominal">
			[
			<xsl:for-each select="./nominal/label">
				<xsl:value-of select="."/><xsl:text> </xsl:text>
			</xsl:for-each>
			]
		</xsl:when>
	</xsl:choose>
	<xsl:apply-templates select="description"/>
</xsl:template>


<xsl:template match="function">
	<xsl:apply-templates/>
</xsl:template>


<xsl:template match="constant">
	Constant function : <I>y</I> = <xsl:value-of select="."/>
</xsl:template>


<xsl:template match="linear">
	Linear function : <I>y</I> = <xsl:value-of select="slope"/> <I>x</I> + <xsl:value-of select="intercept"/>
</xsl:template>


<xsl:template match="piecewiseLinear">
	Piecewise Linear function : <xsl:value-of select="."/>
</xsl:template>


<xsl:template match="points">
	Points : { <xsl:for-each select="point">(<xsl:value-of select="abscissa"/>,<xsl:value-of select="ordinate"/>) </xsl:for-each>}
</xsl:template>


<xsl:template match="element">
	<xsl:choose>
		<xsl:when test="alternativeID"><xsl:value-of select="alternativeID"/></xsl:when>
		<xsl:when test="criterionID"><xsl:value-of select="criterionID"/></xsl:when>
	</xsl:choose>
	<xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="value">
	<xsl:choose>
		<xsl:when test="integer">
			<xsl:value-of select="round(number(./integer))"/>
		</xsl:when>
		<xsl:when test="real">
			<xsl:value-of select="format-number(number(./real), '0.##')"/>
		</xsl:when>
		<xsl:when test="interval">
			[ <xsl:apply-templates select="./interval/lowerBound/*"/> ; <xsl:apply-templates select="./interval/upperBound/*"/> ]
		</xsl:when>
		<xsl:when test="rational">
			<xsl:value-of select="./rational/numerator"/>/<xsl:value-of select="./rational/denominator"/>
		</xsl:when>
		<xsl:when test="label">
			<xsl:value-of select="./label"/>
		</xsl:when>
		<xsl:when test="rankedLabel">
			<xsl:value-of select="./rankedLabel/label"/>(<xsl:value-of select="./rankedLabel/rank"/>)
		</xsl:when>
		<xsl:when test="boolean">
			<xsl:value-of select="./boolean"/>
		</xsl:when>
		<xsl:when test="NA">
			<xsl:value-of select="./NA"/>
		</xsl:when>
		<xsl:when test="image">
			<br/><center><img src='data:image/png;base64,{./image}' alt='image'/></center><br/>
		</xsl:when>
		<xsl:when test="imageRef">
			<br/><center><img src='{./imageRef}' alt='image'/></center><br/>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<xsl:template match="numericValue">
	<xsl:choose>
		<xsl:when test="integer">
			<xsl:value-of select="./integer"/>
		</xsl:when>
		<xsl:when test="real">
			<xsl:value-of select="real"/>
		</xsl:when>
		<xsl:when test="rational">
			<xsl:value-of select="./rational/numerator"/>/<xsl:value-of select="./rational/denominator"/>
		</xsl:when>
		<xsl:when test="NA">
			<xsl:value-of select="./NA"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<xsl:template match="comparisonType">
	<i>Relation</i> : <xsl:value-of select="."/>
</xsl:template>


</xsl:stylesheet>

