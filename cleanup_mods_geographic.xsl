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
        <!-- Change MODS <subject><geographic> to <subject authority='lcsh'><geographic> -->
        <xsl:template match="/mods:mods/mods:subject[not(@authority)]/mods:geographic">
            <xsl:attribute name="authority">lcsh</xsl:attribute>
            <geographic>
                <xsl:apply-templates select="node()[normalize-space()]|@*[normalize-space()]"/>
            </geographic>
        </xsl:template>
    </xsl:stylesheet>
