<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  version="1.0">

  <!-- import FO stylesheet -->
  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl"/>

  <!-- enable highlighting -->
  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/highlight.xsl"/>
  <xsl:param name="highlight.xslthl.config">http://docbook.sourceforge.net/release/xsl/current/highlighting/xslthl-config.xml</xsl:param>
  <xsl:param name="highlight.source">1</xsl:param>

  <!-- set paper size to A4 -->
  <xsl:param name="paper.type">A4</xsl:param>

  <!-- enable double-sided output -->
  <xsl:param name="double.sided" select="1"/>

  <!-- enable numbering on sections -->
  <xsl:param name="section.autolabel">1</xsl:param>

  <!-- include chapter number in section numbers -->
  <xsl:param name="section.label.includes.component.label">1</xsl:param>

  <!-- limit the depth of auto-labelled sections -->
  <xsl:param name="section.autolabel.max.depth">2</xsl:param>

  <!-- set page margins -->
  <xsl:param name="page.margin.top">0.6in</xsl:param>
  <xsl:param name="body.margin.top">0.6in</xsl:param>
  <xsl:param name="page.margin.bottom">0.65in</xsl:param>
  <xsl:param name="body.margin.bottom">0.55in</xsl:param>
  <xsl:param name="page.margin.inner">1.5in</xsl:param>
  <xsl:param name="page.margin.outer">1.1in</xsl:param>

  <!-- set fonts -->
  <xsl:param name="body.font.family">GaramondPro</xsl:param>
  <xsl:param name="title.font.family">Lato</xsl:param>
  <xsl:param name="body.font.master">11</xsl:param>
  <xsl:param name="monospace.font.family">DejaVuSansMono</xsl:param>
  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-size">0.8em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="font-family">Lato</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="component.title.properties">
    <xsl:attribute name="font-family">Lato</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="font-size">1.4em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="book.titlepage.recto.style">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

  <!-- output page references if the xref has 'page' in its 'xrefstyle' -->
  <xsl:param name="insert.xref.page.number">maybe</xsl:param>

  <!-- format header ... -->
  <!-- remove header rule -->
  <xsl:param name="header.rule">0</xsl:param>
  <!-- make left column width 100% -->
  <xsl:param name="header.column.widths">1 0 0</xsl:param>
  <xsl:template name="header.content">
    <xsl:param name="sequence" />
    <xsl:param name="position" />
    <!-- place document title in the left column and make it italic -->
    <fo:block>
      <xsl:choose>
        <xsl:when test="($sequence = 'odd' or $sequence = 'even') and $position = 'left'">
          <fo:inline font-style="italic">
            <!-- do not display a header -->
            <!--
            <xsl:apply-templates select="." mode="title.markup" />
            -->
          </fo:inline>
        </xsl:when>
      </xsl:choose>
    </fo:block>
  </xsl:template>

  <!-- remove footer rule -->
  <xsl:param name="footer.rule">0</xsl:param>

  <!-- format revision history -->
  <xsl:template match="revhistory" mode="titlepage.mode">
    <fo:block space-after="1.5em">
      v<xsl:value-of select="revision/revnumber" />, <xsl:value-of select="revision/date" />
    </fo:block>
  </xsl:template>

  <!-- customize title page -->
  <xsl:template name="book.titlepage.recto">
    <fo:external-graphic src="url(images/title8.pdf)"
      width="auto" height="auto"
      content-width="100%" content-height="auto"
      text-align="center"/>
  </xsl:template>
  <xsl:template name="user.pagemasters">
    <!-- define three page masters for the title page -->
    <fo:simple-page-master master-name="my-titlepage-first"
        page-width="{$page.width}"
        page-height="{$page.height}"
        margin-top="0"
        margin-bottom="0"
        margin-left="0"
        margin-right="0">
      <fo:region-body margin-bottom="0" margin-top="0"
          column-count="{$column.count.titlepage}">
      </fo:region-body>
      <fo:region-before region-name="xsl-region-before-first"
          extent="{$region.before.extent}" display-align="before"/>
      <!-- Do not put an after region on the title page. We don't
           want page numbers there. -->
      <!--<fo:region-after region-name="xsl-region-after-first"
          extent="{$region.after.extent}" display-align="after"/>-->
    </fo:simple-page-master>
    <fo:simple-page-master master-name="my-titlepage-odd"
        page-width="{$page.width}"
        page-height="{$page.height}"
        margin-top="0"
        margin-bottom="0"
        margin-left="0"
        margin-right="0">
      <fo:region-body margin-bottom="0" margin-top="0"
          column-count="{$column.count.titlepage}">
      </fo:region-body>
      <fo:region-before region-name="xsl-region-before-odd"
          extent="{$region.before.extent}" display-align="before"/>
      <!-- Do not put an after region on the title page. We don't
           want page numbers there. -->
      <!--<fo:region-after region-name="xsl-region-after-odd"
          extent="{$region.after.extent}" display-align="after"/>-->
    </fo:simple-page-master>
    <fo:simple-page-master master-name="my-titlepage-even"
        page-width="{$page.width}"
        page-height="{$page.height}"
        margin-top="0"
        margin-bottom="0"
        margin-left="0"
        margin-right="0">
      <fo:region-body margin-bottom="0" margin-top="0"
          column-count="{$column.count.titlepage}">
      </fo:region-body>
      <fo:region-before region-name="xsl-region-before-even"
          extent="{$region.before.extent}" display-align="before"/>
      <!-- Do not put an after region on the title page. We don't
           want page numbers there. -->
      <!-- <fo:region-after region-name="xsl-region-after-even"
          extent="{$region.after.extent}" display-align="after"/> -->
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="my-titlepage">
      <!-- select the right page master -->
      <fo:repeatable-page-master-alternatives>
          <fo:conditional-page-master-reference
              master-reference="blank"
              blank-or-not-blank="blank"/>
          <fo:conditional-page-master-reference
              master-reference="my-titlepage-first"
              page-position="first"/>
          <fo:conditional-page-master-reference
              master-reference="my-titlepage-odd"
              odd-or-even="odd"/>
          <fo:conditional-page-master-reference
              master-reference="my-titlepage-even"
              odd-or-even="even"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </xsl:template>
  <xsl:template name="select.user.pagemaster">
    <xsl:param name="element"/>
    <xsl:param name="pageclass"/>
    <xsl:param name="default-pagemaster"/>
    <xsl:choose>
      <xsl:when test="$default-pagemaster = 'titlepage'">
        <!-- return name of custom title page sequence master -->
        <xsl:value-of select="'my-titlepage'" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default-pagemaster"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- remove text on back of title page -->
  <xsl:template name="book.titlepage.verso"/>

  <!-- generate a toc but no list of figures or list of tables -->
  <xsl:param name="generate.toc">
    book toc,title
    <!-- book toc,title,figure,table,example,equation -->
  </xsl:param>

  <!-- format bibliography ... -->
  <!-- do not indent anything in bibliography because we're going to use tables-->
  <xsl:attribute-set name="biblioentry.properties" use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="start-indent">0pt</xsl:attribute>
    <xsl:attribute name="text-indent">0pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:template match="anchor" mode="bibliomixed.mode">
    <!-- simply put the xreflabel in square brackets here, the anchor
         will be placed before the table -->
    [<xsl:value-of select="@xreflabel" />]
  </xsl:template>
  <xsl:template match="bibliomisc" mode="bibliomixed.mode">
    <!-- place anchor here -->
    <xsl:apply-templates select="anchor" />
    <!-- put label and text into two columns of one table -->
    <fo:table table-layout="fixed" width="100%">
      <fo:table-column column-width="2.5em" column-number="1" />
      <fo:table-column column-width="proportional-column-width(1)" column-number="2" />
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block>
              <xsl:apply-templates select="anchor" mode="bibliomixed.mode" />
            </fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block>
              <xsl:value-of select="." />
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <!-- add a border to blockquotes -->
  <xsl:template match="blockquote">
    <fo:block border-left-width="3pt" border-left-style="solid" border-left-color="#ebebec"
      margin-left="1.1em" margin-top="1em" margin-bottom="1em">
      <fo:block margin-left="-2em">
        <xsl:apply-imports />
      </fo:block>
    </fo:block>
  </xsl:template>

  <!-- format dedication title -->
  <xsl:attribute-set name="dedication.titlepage.recto.style">
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="dedication.titlepage.title.properties">
    <xsl:attribute name="font-family">Lato</xsl:attribute>
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="font-size">
      <!-- same font-size as in section level 1 -->
      <xsl:value-of select="$body.font.master * 1.7"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="padding-top">
      <xsl:value-of select="$body.font.master * 6"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="padding-bottom">
      <xsl:value-of select="$body.font.master * 2"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <!-- configure new template for dedication title -->
  <xsl:template name="dedication.titlepage.recto">
    <fo:block xsl:use-attribute-sets="dedication.titlepage.recto.style">
      <fo:block xsl:use-attribute-sets="dedication.titlepage.title.properties">
        <xsl:apply-templates select="." mode="title.markup"/>
      </fo:block>
    </fo:block>
  </xsl:template>
  <!-- make dedication paragraphs a bit smaller -->
  <xsl:template match="dedication/simpara|dedication/itemizedlist">
    <fo:block start-indent="0.4in" end-indent="0.4in">
      <xsl:apply-imports/>
    </fo:block>
  </xsl:template>

  <!-- format colophon so it looks the same as dedication -->
  <xsl:template name="colophon.titlepage.recto">
    <fo:block xsl:use-attribute-sets="dedication.titlepage.recto.style">
      <fo:block xsl:use-attribute-sets="dedication.titlepage.title.properties">
        <xsl:apply-templates select="." mode="title.markup"/>
      </fo:block>
    </fo:block>
  </xsl:template>
  <xsl:template match="colophon/simpara|colophon/itemizedlist">
    <fo:block start-indent="0.4in" end-indent="0.4in">
      <xsl:apply-imports/>
    </fo:block>
  </xsl:template>

  <!-- format list-of-figures title -->
  <xsl:template name="list.of.figures.titlepage.recto">
    <fo:block xsl:use-attribute-sets="list.of.figures.titlepage.recto.style"
        space-after="{$body.font.master * 2}" padding-top="{$body.font.master * 6}"
        start-indent="0pt" font-weight="normal" font-family="{$title.fontset}">
      <xsl:attribute name="font-size">
        <!-- same font-size as in section level 1 -->
        <xsl:value-of select="$body.font.master * 1.7"></xsl:value-of>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'ListofFigures'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <!-- format list-of-tables title -->
  <xsl:template name="list.of.tables.titlepage.recto">
    <fo:block xsl:use-attribute-sets="list.of.tables.titlepage.recto.style"
        space-after="{$body.font.master * 2}" padding-top="{$body.font.master * 6}"
        start-indent="0pt" font-weight="normal" font-family="{$title.fontset}">
      <xsl:attribute name="font-size">
        <!-- same font-size as in section level 1 -->
        <xsl:value-of select="$body.font.master * 1.7"></xsl:value-of>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'ListofTables'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <!-- format toc title -->
  <xsl:template name="table.of.contents.titlepage.recto">
    <fo:block xsl:use-attribute-sets="table.of.contents.titlepage.recto.style"
        space-after="{$body.font.master * 2}" padding-top="{$body.font.master * 6}"
        start-indent="0pt" font-weight="normal" font-family="{$title.fontset}">
      <xsl:attribute name="font-size">
        <!-- same font-size as in section level 1 -->
        <xsl:value-of select="$body.font.master * 1.7"></xsl:value-of>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'TableofContents'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <!-- format bibliography title -->
  <xsl:template name="bibliography.titlepage.recto">
    <fo:block xsl:use-attribute-sets="bibliography.titlepage.recto.style"
        space-after="{$body.font.master * 2}" padding-top="{$body.font.master * 6}"
        start-indent="0pt" font-weight="normal" font-family="{$title.fontset}">
      <xsl:attribute name="font-size">
        <!-- same font-size as appendix title -->
        <xsl:value-of select="$body.font.master * 2"></xsl:value-of>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Bibliography'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <!-- format appendix title -->
  <xsl:template name="appendix.titlepage.recto">
    <fo:block xsl:use-attribute-sets="appendix.titlepage.recto.style"
        space-after="{$body.font.master * 2}" padding-top="{$body.font.master * 6}"
        start-indent="0pt" font-weight="normal" font-family="{$title.fontset}">
      <xsl:attribute name="font-size">
        <!-- same font-size as bibliography title -->
        <xsl:value-of select="$body.font.master * 2"></xsl:value-of>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Appendix'"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="." mode="label.markup"/>.
      <xsl:apply-templates select="." mode="title.markup"/>
    </fo:block>
  </xsl:template>

  <!-- no dot between label and title in toc -->
  <xsl:param name="autotoc.label.separator"></xsl:param>

  <!-- set font-weight and top padding for chapters in toc -->
  <xsl:attribute-set name="toc.line.properties">
    <xsl:attribute name="font-weight">
      <xsl:choose>
        <xsl:when test="self::chapter or self::bibliography or self::appendix">bold</xsl:when>
        <xsl:otherwise>normal</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="padding-top">
      <xsl:choose>
        <xsl:when test="self::chapter or self::bibliography or self::appendix">
          <xsl:value-of select="$body.font.master"></xsl:value-of>
          <xsl:text>pt</xsl:text>
        </xsl:when>
        <xsl:otherwise>0pt</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-page">
      <xsl:choose>
        <xsl:when test="self::chapter or self::bibliography or self::appendix">always</xsl:when>
        <xsl:otherwise>auto</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- format toc line so entries are aligned -
    we replace fo:block from the default template by fo:list-block -->
  <xsl:template name="toc.line">
    <xsl:param name="toc-context" select="NOTANODE"/>

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>

    <!-- Define indentations for the different levels in the toc -->
    <xsl:variable name="indent1">0pt</xsl:variable>
    <xsl:variable name="indent2">20pt</xsl:variable>
    <xsl:variable name="indent3">47pt</xsl:variable>
    <xsl:variable name="indent4">83pt</xsl:variable>

    <fo:list-block xsl:use-attribute-sets="toc.line.properties">
      <!-- Define indentation for list item labels -->
      <xsl:variable name="label-indent">
        <xsl:choose>
          <xsl:when test="count(ancestor::*) = 1"><xsl:value-of select="$indent1"/></xsl:when>
          <xsl:when test="count(ancestor::*) = 2"><xsl:value-of select="$indent2"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$indent3"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!-- Define indentation for list item bodies -->
      <xsl:variable name="body-indent">
        <xsl:choose>
          <xsl:when test="$label != ''">
            <!-- Define indentation if there is a label (chapters, sections, etc.) -->
            <xsl:choose>
              <xsl:when test="count(ancestor::*) = 1"><xsl:value-of select="$indent2"/></xsl:when>
              <xsl:when test="count(ancestor::*) = 2"><xsl:value-of select="$indent3"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="$indent4"/></xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <!-- Define indentation if there is no label (bibliography, etc.) -->
            <xsl:value-of select="$label-indent"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <fo:list-item>
        <fo:list-item-label start-indent="{$label-indent}">
          <fo:block>
            <fo:basic-link internal-destination="{$id}">
              <xsl:if test="$label != ''">
                <xsl:copy-of select="$label"/>
                <xsl:value-of select="$autotoc.label.separator"/>
              </xsl:if>
            </fo:basic-link>
          </fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="{$body-indent}">
          <fo:block>
            <fo:inline keep-with-next.within-line="always">
              <fo:basic-link internal-destination="{$id}">
                <xsl:apply-templates select="." mode="titleabbrev.markup"/>
              </fo:basic-link>
            </fo:inline>
            <fo:inline keep-together.within-line="always">
              <!-- make leader invisible because alignment does not work
                   in FOP 2.1, it's not implemented yet -->
              <fo:leader leader-pattern="space"
                        keep-with-next.within-line="always"/>
              <fo:basic-link internal-destination="{$id}">
                <fo:page-number-citation ref-id="{$id}" />
              </fo:basic-link>
            </fo:inline>
          </fo:block>
        </fo:list-item-body>
      </fo:list-item>
    </fo:list-block>
  </xsl:template>

  <!-- customize generated text -->
  <xsl:param name="local.l10n.xml" select="document('')" />
  <l:i18n>
    <l:l10n language="en">
      <l:context name="xref-number-and-title">
        <!-- references to sections and figures should only include the number -->
        <l:template name="figure" text="%n" />
        <l:template name="section" text="%n" />
        <l:template name="table" text="%n" />
        <!-- references to chapters and appendices should include number and title -->
        <l:template name="chapter" text="%n, %t" />
        <l:template name="appendix" text="%n, %t" />
      </l:context>
      <l:context name="xref">
        <!-- customise xrefstyle 'Page' -->
        <l:template name="Page" text="on page %p"/>
      </l:context>
      <!-- section numbers should not end with a dot -->
      <l:context name="title-numbered">
        <!-- &#8196; 1/3 em space -->
        <l:template name="section" text="%n&#8196;%t"/>
      </l:context>
      <!-- figure labels should not end with a dot -->
      <l:context name="title">
        <l:template name="figure" text="Figure %n&#8196;%t"/>
        <l:template name="table" text="Table %n&#8196;%t"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <!-- Figure/table labels should not end with a dot. Plus: we add a
       a small whitespace between 'Figure'/'Table' and the title but we
       have to do this in normal font-style and not italic, because the
       character is not available in Adobe Garamond Pro Italic -->
  <xsl:template match="figure|table" mode="object.title.markup">
    <xsl:param name="object" select="."/>
    <fo:block>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="local-name($object)"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="$object" mode="label.markup"/>
      <fo:inline font-style="normal"><xsl:text>&#8196;</xsl:text></fo:inline>
      <xsl:apply-templates select="$object" mode="title.markup"/>
    </fo:block>
  </xsl:template>

  <!-- put figures with role=top in footnote. Our hacked version of FOP
       will move footnotes with the prefix '_hack_footnote_top' to the top of the page -->
  <xsl:template match="figure[@role='top']|table[@role='top']">
    <fo:block>
      <fo:footnote>
        <fo:inline/>
        <fo:footnote-body id="_hack_footnote_top-{generate-id(.)}">
          <xsl:apply-imports/>
        </fo:footnote-body>
      </fo:footnote>
    </fo:block>
  </xsl:template>

  <!-- put figures with role=bottom in footnote. Our hacked version of FOP will remove the separator from footnotes with the prefix '_hack_footnote_bottom' and move them down a bit -->
  <xsl:template match="figure[@role='bottom']">
    <fo:footnote>
      <fo:inline/>
      <fo:footnote-body id="_hack_footnote_bottom-{generate-id(.)}" >
        <xsl:apply-imports/>
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>

  <!-- define role for margin-top single-spacer -->
  <xsl:template match="simpara[@role='mt-1']">
    <fo:block space-before.minimum="0.8em" space-before.optimum="0.8em" space-before.maximum="0.8em">
      <xsl:apply-imports/>
    </fo:block>
  </xsl:template>

  <!-- titles should be placed after figures, tables, etc. -->
  <xsl:param name="formal.title.placement">
    figure after
    example after
    equation after
    table after
    procedure after
  </xsl:param>

  <xsl:attribute-set name="figure.properties">
    <!-- center figures -->
    <xsl:attribute name="text-align">center</xsl:attribute>

    <!-- space before figures -->
    <xsl:attribute name="space-before.optimum">1.5em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">1.3em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.7em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.properties">
    <!-- space before tables -->
    <xsl:attribute name="space-before.optimum">1.5em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">1.3em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.7em</xsl:attribute>
  </xsl:attribute-set>

  <!-- format formal titles (figure captions, etc.) -->
  <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>

    <!-- do not indent figure captions -->
    <xsl:attribute name="text-indent">0pt</xsl:attribute>

    <!-- space after figure captions -->
    <xsl:attribute name="space-after.optimum">1.5em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">1.3em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">1.7em</xsl:attribute>

    <xsl:attribute name="space-before.optimum">
      <xsl:choose>
        <xsl:when test="self::table">0.6em</xsl:when>
        <xsl:otherwise>0em</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">
      <xsl:choose>
        <xsl:when test="self::table">0.4em</xsl:when>
        <xsl:otherwise>0em</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="space-before.maximum">
      <xsl:choose>
        <xsl:when test="self::table">0.8em</xsl:when>
        <xsl:otherwise>0em</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="normal.para.spacing">
    <!-- fix problem with extra line space after lines that have
         <fo:inline> elements with another font -->
    <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>

    <!-- no space between paragraphs -->
    <xsl:attribute name="space-before.optimum">0em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0em</xsl:attribute>

    <!-- indent first line of paragraph -->
    <xsl:attribute name="text-indent">
      <xsl:choose>
        <!-- no indention for block quoted -->
        <xsl:when test="parent::blockquote">0pt</xsl:when>
        <!-- no indention for table cells -->
        <xsl:when test="parent::entry">0pt</xsl:when>
        <!-- no indention for elements after titles -->
        <xsl:when test="preceding-sibling::title/following-sibling::simpara[1]=current()">0pt</xsl:when>
        <!-- set indention for all other elements -->
        <xsl:otherwise>1em</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="title.margin.left">0pt</xsl:param>
  <xsl:param name="body.start.indent">0pt</xsl:param>

  <!-- space before and after section titles -->
  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="padding-top">16pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">14pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- space before and after block quotes (will already be
       handled by the blockquote template above) -->
  <xsl:attribute-set name="blockquote.properties">
    <xsl:attribute name="padding-top">0em</xsl:attribute>
    <xsl:attribute name="padding-bottom">0em</xsl:attribute>
  </xsl:attribute-set>

  <!-- space before and after component (bibliography, glossary, ...) titles -->
  <xsl:attribute-set name="component.title.properties">
    <xsl:attribute name="padding-top">1.5em</xsl:attribute>
    <xsl:attribute name="padding-bottom">14pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- format chapter title -->
  <xsl:attribute-set name="chapter.titlepage.recto.style">
    <xsl:attribute name="text-align">right</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
  </xsl:attribute-set>
  <!-- format chapter label (large number) -->
  <xsl:attribute-set name="chapter.titlepage.label.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 12"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="color">#ebebec</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="padding-bottom">
      <xsl:value-of select="$body.font.master * -2"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <!-- format chapter title -->
  <xsl:attribute-set name="chapter.titlepage.title.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 4"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">
      <xsl:value-of select="$body.font.master * 3"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <!-- configure new template for chapter title -->
  <xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
    <fo:block xsl:use-attribute-sets="chapter.titlepage.recto.style">
      <fo:block xsl:use-attribute-sets="chapter.titlepage.label.properties">
        <xsl:apply-templates select=".." mode="label.markup"/>
      </fo:block>
      <fo:block xsl:use-attribute-sets="chapter.titlepage.title.properties">
        <xsl:apply-templates select=".." mode="title.markup"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!-- font sizes of section titles -->
  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.7"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.5"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.15"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.15"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.15"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level6.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.15"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- format sidebar blocks -->
  <xsl:attribute-set name="sidebar.properties">
    <xsl:attribute name="border-style">none</xsl:attribute>
    <xsl:attribute name="background-color">transparent</xsl:attribute>
    <xsl:attribute name="font-family">Lato</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.85"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">8pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">0pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="sidebar.title.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"></xsl:value-of>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:template match="sidebar">
    <fo:block border-top-width="3pt" border-top-style="solid" border-top-color="#ebebec" border-bottom-width="3pt" border-bottom-style="solid" border-bottom-color="#ebebec"
      space-before.minimum="1.2em" space-before.optimum="1.3em" space-before.maximum="1.5em" space-after.minimum="1.2em" space-after.optimum="1.3em" space-after.maximum="1.5em">
      <xsl:apply-imports />
    </fo:block>
  </xsl:template>

  <!-- define a passthrough element that lets us pass through XML to the FO processor -->
  <xsl:template match="passthrough">
    <xsl:copy-of select="*"/>
  </xsl:template>
</xsl:stylesheet>