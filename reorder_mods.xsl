<!-- MAM.
This XSLT reorders a MODS record to Digital Grinnell standards.  It does NOT remove
empty elements!  Use the cleanup_mods.xsl transform for that!

Modified in November 2015 to produce a new order with some differnt logic than was applied earlier.  The
new logic lifted from http://stackoverflow.com/questions/8305258/rearrange-xml-nodes-including-sub-nodes-by-xslt

Important!!!  All possible elements MUST be accounted for here.  Any that are NOT present will be
discarded when this transform is applied!
-->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="text/xml"/>
  <xsl:strip-space elements="*"/>
  
  <xsl:template match="mods:mods">
    <xsl:copy>
      <!-- The order of the following statements is SIGNIFICANT!  Don't change this unless you know what you are doing! -->
      <!-- copy elements in a specific order  -->
      <xsl:apply-templates select="mods:name[mods:role/mods:roleTerm[text()='creator' or text()='author' or text()='artist']]"/>      
      <xsl:apply-templates select="mods:titleInfo[not(@type='alternative')]" />
      <xsl:apply-templates select="mods:titleInfo[@type='alternative']" />
      <xsl:apply-templates select="mods:name[mods:role/mods:roleTerm[text()!='creator' and text()!='author' and text()!='artist']]"/>      
      <xsl:apply-templates select="mods:abstract"/>
      <xsl:apply-templates select="mods:originInfo" />
      <xsl:apply-templates select="mods:typeOfResource"/>
      <xsl:apply-templates select="mods:genre"/>
      <xsl:apply-templates select="mods:physicalDescription[@displayLabel='Physical']"/>    <!-- Physical/original object -->
      <xsl:apply-templates select="mods:physicalDescription[not(@displayLabel='Physical')]"/>    <!-- Digital object -->
      <xsl:apply-templates select="mods:note[@type]"/>         <!-- public notes with no type attribute -->
      <xsl:apply-templates select="mods:note[not(@type)]"/>    <!-- public notes with any type attribute -->
      <xsl:apply-templates select="mods:language"/>
      <xsl:apply-templates select="mods:tableOfContents"/>
      <xsl:apply-templates select="mods:subject[@authority][mods:topic]"/>
      <xsl:apply-templates select="mods:subject[@authority][mods:geographic]"/>
      <xsl:apply-templates select="mods:subject[@authority][mods:temporal]"/>
      <xsl:apply-templates select="mods:subject[not(@authority)]"/>
      <xsl:apply-templates select="mods:classification"/>
      <xsl:apply-templates select="mods:relatedItem[not(@type='admin') and not(@displayLabel='Transcribe This Item')]"/>  <!-- Regular relations...excludes Private notes -->
      <xsl:apply-templates select="mods:relatedItem[@displayLabel='Transcribe This Item']"/>  <!-- Old transcription scheme -->
      <xsl:apply-templates select="mods:relatedItem[@type='admin']"/>                         <!-- Catch-all for PRIVATE notes -->
      <xsl:apply-templates select="mods:identifier[not(@type='local')]"/>
      <xsl:apply-templates select="mods:identifier[@type='local']"/>
      <xsl:apply-templates select="mods:location"/>
      <xsl:apply-templates select="mods:accessCondition"/>
      <xsl:apply-templates select="mods:extension"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- originInfo and its sub-elements -->
  <xsl:template match="mods:originInfo">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="mods:dateCreated"/>
      <xsl:apply-templates select="mods:dateIssued"/>
      <xsl:apply-templates select="mods:edition"/>
      <xsl:apply-templates select="mods:publisher"/>
      <xsl:apply-templates select="*[not(self::mods:dateCreated or self::mods:dateIssued or self::mods:edition or self::mods:publisher)]"/>
    </xsl:copy>
  </xsl:template>

  <!-- physicalDescription with @displayLabel='Physical' and its sub-elements -->
  <xsl:template match="mods:physicalDescription[@displayLabel='Physical']">    <!-- Physical/original object -->
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="mods:extent"/>
      <xsl:apply-templates select="mods:form"/>
      <xsl:apply-templates select="*[not(self::mods:extent or self::mods:form)]"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- physicalDescription without @displayLabel='Physical' and its sub-elements -->
  <xsl:template match="mods:physicalDescription[not(@displayLabel='Physical')]">    <!-- Digital object -->
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="mods:digitalOrigin"/>
      <xsl:apply-templates select="mods:extent"/>
      <xsl:apply-templates select="mods:internetMediaType"/>
      <xsl:apply-templates select="*[not(self::mods:digitalOrigin or self::mods:extent or self::mods:internetMediaType)]"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- this is the identity transform: it copies everything that isn't matched by a more specific template -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template> 
  
</xsl:stylesheet>

