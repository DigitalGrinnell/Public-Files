<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
                xmlns:mads="http://www.loc.gov/mads/v2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:dc="http://purl.org/dc/elements/1.1/">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="//dc:title">
        <xsl:element name="mads:authority">
            <xsl:element name="mads:titleInfo">
                <xsl:element name="mads:title">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//dc:description">
        <xsl:element name="mads:note">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="/">
        <mads:mads xmlns="http://www.loc.gov/mads/v2" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mads="http://www.loc.gov/mads/v2">            <xsl:apply-templates select="//mads:authority/mads:titleInfo/mads:title" />
            <xsl:apply-templates select="//dc:title" />
            <xsl:apply-templates select="//dc:description" />
        </mads:mads>
    </xsl:template>

    <!-- suppress all else:-->

    <xsl:template match="*"/>

</xsl:stylesheet>

