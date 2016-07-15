<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns="http://www.loc.gov/mods/v3"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mods="http://www.loc.gov/mods/v3">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="text/xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:template
      match="*[not(node())] | *[not(node()[2]) and node()/self::text() and not(normalize-space())]"/>
  <xsl:template
      match="mods:name[not(mods:namePart)]"/>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()[normalize-space()]|@*[normalize-space()]"/>
    </xsl:copy>
  </xsl:template>
<!-- Change MODS <genre> to <typeOfResource> -->
  <xsl:template match="/mods:mods/mods:genre">
      <typeOfResource>
          <xsl:apply-templates select="node()[normalize-space()]|@*[normalize-space()]"/>
      </typeOfResource>
  </xsl:template>
</xsl:stylesheet>
