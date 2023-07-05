import { test, expect, type Page } from '@playwright/test';

// test.beforeEach(async ({ page }) => {
//   await page.goto('http://localhost:3000');
// });

test('has title', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await expect(page).toHaveTitle(/SHARIAsource/);
});

test('correct_featured_sections', async({ page }) => {
  await page.goto('http://localhost:3000');

  // Featured Documents
  let featured_docs = page.locator('div.featured-documents').locator(".home-block");
  await expect(featured_docs.locator(".home-block-heading")).toHaveText('Featured Documents');
  let featured_docs_featured_item = featured_docs.locator(".featured-item");
  await expect (featured_docs_featured_item).toBeVisible();
  // the featured item should havea a p.breadcrumb with a link containing "/search?", an h3 with an inner link matching the pattern /documents, a p.byline, and a div.summary
  await expect(featured_docs_featured_item.locator("p.breadcrumb > a")).toHaveAttribute('href', /\/search?/);
  await expect(featured_docs_featured_item.locator("h3 > a")).toHaveAttribute('href', /\/documents\/\d+/);
  await expect(featured_docs_featured_item.locator("p.byline")).toHaveText(/by/);
  await expect(featured_docs_featured_item.locator("div.summary")).toBeVisible();
  // Aside items
  let aside_items = featured_docs.locator(".aside-items");
  // There should be two h3 items and two p items
  await expect(aside_items.locator("h3")).toHaveCount(2);
  await expect(aside_items.locator("p")).toHaveCount(2);
  // There should be a link with the class ss-button and a href to https://islamiclaw.blog/
  await expect(aside_items.locator("a.ss-button")).toHaveAttribute('href', /https:\/\/islamiclaw.blog\//);

  // Popular Documents
  let popular_docs = page.locator('div.popular-documents').locator(".home-block");
  await expect(popular_docs.locator(".home-block-heading")).toHaveText('Popular Documents');
  let popular_docs_featured_item = popular_docs.locator(".featured-item");
  // the featured item should havea a p.breadcrumb with a link with the pattern /search, an h3 with an inner link matching the pattern /documents, a p.byline, and a div.summary
  await expect(popular_docs_featured_item.locator("p.breadcrumb > a")).toHaveAttribute('href', /\/search/);
  await expect(popular_docs_featured_item.locator("h3 > a")).toHaveAttribute('href', /\/documents\/\d+/);
  await expect(popular_docs_featured_item.locator("p.byline")).toHaveText(/by/);
  await expect(popular_docs_featured_item.locator("div.summary")).toBeVisible();
  // Aside items
  let popular_docs_aside_items = popular_docs.locator(".aside-items");
  // There should be two h3 items and two p items
  await expect(popular_docs_aside_items.locator("h3")).toHaveCount(2);
  await expect(popular_docs_aside_items.locator("p")).toHaveCount(2);

  // Featured Collections
  let featured_collections = page.locator('div.featured-collections').locator(".home-block");
  await expect(featured_collections.locator(".home-block-heading")).toHaveText('Featured Collections');
  let featured_collections_featured_item = featured_collections.locator(".featured-item");
  await expect(featured_collections_featured_item.locator("p.breadcrumb > a")).toHaveAttribute('href', /\/resources/);
  await expect(featured_collections_featured_item.locator("p.breadcrumb > a")).toHaveText("Special Collections");
  let collections_aside_items = featured_collections.locator(".aside-items");
  await expect(collections_aside_items.locator("h3")).toHaveCount(2);
  await expect(collections_aside_items.locator("p")).toHaveCount(2);

  // Library Portal
  let library_portal = page.locator('div.library-portal').locator(".home-block");
  await expect(library_portal.locator(".home-block-heading")).toHaveText('Library Portal');
  let library_block = library_portal.locator(".libraries");
  // library_block should have 3 child div.library items, each with an H3 and a link
  await expect(library_block.locator("div.library")).toHaveCount(3);
  await expect(library_block.locator("div.library > h3")).toHaveCount(3);
  await expect(library_block.locator("div.library > h3 > a")).toHaveCount(3);

});

test('header_navigation', async ({ page }) => {
  await page.goto('http://localhost:3000');

  // There should be a nav.top-bar item
  let navbar = page.locator("div.inner-wrapper").locator("nav.header");
  await expect(navbar).toBeVisible();

  let site_nav = navbar.locator("ul.site-nav");
  await expect(site_nav).toBeVisible();
  await expect(site_nav.locator("li")).toHaveCount(7);
  await expect(site_nav.locator("li:nth-child(1) > a")).toHaveText("Topics & Themes");
  await expect(site_nav.locator("li:nth-child(1) > a")).toHaveAttribute('href', /\/topics/);
  await expect(site_nav.locator("li:nth-child(2) > a")).toHaveText("Geographic Regions");
  await expect(site_nav.locator("li:nth-child(2) > a")).toHaveAttribute('href', /\/regions/);
  await expect(site_nav.locator("li:nth-child(3) > a")).toHaveText("Empires & Eras");
  await expect(site_nav.locator("li:nth-child(3) > a")).toHaveAttribute('href', /\/eras/);
  await expect(site_nav.locator("li:nth-child(4) > a")).toHaveText("Document Types");
  await expect(site_nav.locator("li:nth-child(4) > a")).toHaveAttribute('href', /\/document-types/);
  await expect(site_nav.locator("li:nth-child(5) > a")).toHaveText("Editors & Contributors");
  await expect(site_nav.locator("li:nth-child(5) > a")).toHaveAttribute('href', /\/contributors/);
  await expect(site_nav.locator("li:nth-child(6) > a")).toHaveText("Special Collections");
  await expect(site_nav.locator("li:nth-child(6) > a")).toHaveAttribute('href', /\/resources/);
  await expect(site_nav.locator("li:nth-child(7) > a")).toHaveText("About SHARIAsource");
  await expect(site_nav.locator("li:nth-child(7) > a")).toHaveAttribute('href', /\/about/);

  let socials = navbar.locator("div.header-social-links").locator("ul.social-links");
  await expect(socials.locator("li")).toHaveCount(4);
  await expect(socials.locator("li:nth-child(1) > a")).toHaveAttribute('href', /https:\/\/twitter.com\/shariasource/);
  await expect(socials.locator("li:nth-child(2) > a")).toHaveAttribute('href', /https:\/\/www.facebook.com\/SHARIAsource.at.HARVARD/);
  await expect(socials.locator("li:nth-child(3) > a")).toHaveAttribute('href', /https:\/\/islamiclaw.blog/);
  await expect(socials.locator("li:nth-child(4)")).toHaveClass("login-link"); // Text and href is not always visible (e.g. if logged in)

});

test('footer_navigation', async ({ page }) => {
  await page.goto('http://localhost:3000');

  let footer = page.locator(".footer").locator(".inner");
  // There should be an h2 with the text "SHARIAsource at Harvard Law School"
  await expect(footer.locator("h2")).toHaveText("SHARIAsource at Harvard Law School");

  let info = footer.locator("div.info");
  await expect(info.locator("p:nth-child(1)")).toHaveText("The online portal for academic content and context on Islamic law");
  await expect(info.locator("p:nth-child(2) > a")).toHaveText("pil@law.harvard.edu")
  let socials = info.locator("ul.social-links");
  await expect(socials.locator("li")).toHaveCount(4);
  await expect(socials.locator("li:nth-child(1) > a")).toHaveAttribute('href', /https:\/\/twitter.com\/shariasource/);
  await expect(socials.locator("li:nth-child(2) > a")).toHaveAttribute('href', /https:\/\/www.facebook.com\/SHARIAsource.at.HARVARD/);
  await expect(socials.locator("li:nth-child(3) > a")).toHaveAttribute('href', /https:\/\/islamiclaw.blog/);
  await expect(socials.locator("li:nth-child(4)")).toHaveClass("login-link"); // Text and href is not always visible (e.g. if logged in)

  // There should be two divs with the class "footer-nav"
  await expect(footer.locator("div.footer-nav")).toHaveCount(2);
  // Get the first div.footer-nav
  let footer_nav = footer.locator("div.footer-nav.left").locator("ul");
  await expect(footer_nav.locator("li")).toHaveCount(6);
  await expect(footer_nav.locator("li:nth-child(1) > a")).toHaveText("Topics & Themes");
  await expect(footer_nav.locator("li:nth-child(1) > a")).toHaveAttribute('href', /\/topics/);
  await expect(footer_nav.locator("li:nth-child(2) > a")).toHaveText("Geographic Regions");
  await expect(footer_nav.locator("li:nth-child(2) > a")).toHaveAttribute('href', /\/regions/);
  await expect(footer_nav.locator("li:nth-child(3) > a")).toHaveText("Empires & Eras");
  await expect(footer_nav.locator("li:nth-child(3) > a")).toHaveAttribute('href', /\/eras/);
  await expect(footer_nav.locator("li:nth-child(4) > a")).toHaveText("Document Types");
  await expect(footer_nav.locator("li:nth-child(4) > a")).toHaveAttribute('href', /\/document-types/);
  // TODO standardize language - "Editors & Contributors" vs "Contributors", "Special Collections" vs "Resources"
  // TODO should these items be duplicated in the footer?
  await expect(footer_nav.locator("li:nth-child(5) > a")).toHaveText("Contributors");
  await expect(footer_nav.locator("li:nth-child(5) > a")).toHaveAttribute('href', /\/contributors/);
  await expect(footer_nav.locator("li:nth-child(6) > a")).toHaveText("Resources");
  await expect(footer_nav.locator("li:nth-child(6) > a")).toHaveAttribute('href', /\/resources/);

  // Get the second
  footer_nav = footer.locator("div.footer-nav.right").locator("ul");
  await expect(footer_nav.locator("li")).toHaveCount(6);
  await expect(footer_nav.locator("li:nth-child(1) > a")).toHaveText("About SHARIAsource");
  await expect(footer_nav.locator("li:nth-child(1) > a")).toHaveAttribute('href', /\/about/);
  await expect(footer_nav.locator("li:nth-child(2) > a")).toHaveText("Advanced Search");
  await expect(footer_nav.locator("li:nth-child(2) > a")).toHaveAttribute('href', /\/search/);
  await expect(footer_nav.locator("li:nth-child(3) > a")).toHaveText("Contributor Login");
  await expect(footer_nav.locator("li:nth-child(3) > a")).toHaveAttribute('href', /\/users\/login/);
  await expect(footer_nav.locator("li:nth-child(4) > a")).toHaveText("Contributors' Terms of Use");
  await expect(footer_nav.locator("li:nth-child(4) > a")).toHaveAttribute('href', /\/terms-of-use/);
  await expect(footer_nav.locator("li:nth-child(5) > a")).toHaveText("Site Policies");
  await expect(footer_nav.locator("li:nth-child(5) > a")).toHaveAttribute('href', /\/privacy-policy/);
  await expect(footer_nav.locator("li:nth-child(6) > a")).toHaveText("Credits");
  await expect(footer_nav.locator("li:nth-child(6) > a")).toHaveAttribute('href', /\/credits/);

});

test('topics_page', async ({ page }) => {
  await page.goto('http://localhost:3000/topics');

  // TODO should be an H1 a11y issue
  await expect(page.locator("h2.browse")).toHaveText("Browse Topics & Themes");

  await expect(page.locator("h2.viz-title")).toHaveCount(2); // Topics, Themes
  await expect(page.locator("div.show-hide-visuals")).toHaveText("Text Search Only");

  // There should be a table.browse-table with th and scope="col". The th items should have the text: Topics; Historical Primary Sources; Contemporary Primary Sources; Sources By School; Expert Analysis; Other Legal Documents; Special Collections
  let table = page.locator("table.browse-table");
  await expect(table.locator("th[scope='col']")).toHaveCount(7);
  // TODO maybe fix these so we're not using <br> for the lines? Ends up looking like the below (a11y issue?)
  await expect(table.locator("th[scope='col']:nth-child(1)")).toHaveText("Topics");
  await expect(table.locator("th[scope='col']:nth-child(2)")).toHaveText("HistoricalPrimarySources");
  await expect(table.locator("th[scope='col']:nth-child(3)")).toHaveText("ContemporaryPrimarySources");
  await expect(table.locator("th[scope='col']:nth-child(4)")).toHaveText("SourcesBySchool");
  await expect(table.locator("th[scope='col']:nth-child(5)")).toHaveText("ExpertAnalysis");
  await expect(table.locator("th[scope='col']:nth-child(6)")).toHaveText("OtherLegalDocuments");
  await expect(table.locator("th[scope='col']:nth-child(7)")).toHaveText("SpecialCollections");

  // There should be at least 30 rows in the table
  const rowCount = await page.$$eval(`table.browse-table tr`, (rows) => rows.length);
  expect(rowCount).toBeGreaterThan(30);

});

test('regions_page', async ({ page }) => {
  // test.slow(); // triples the timeout from 30 to 90 seconds; TODO need to fix the caching
  test.setTimeout(300000); // 5 minutes
  await page.goto('http://localhost:3000/regions');

  // TODO should be two separate headings for Geographic Regions and Empires & Eras
  await expect(page.locator("h2.browse")).toHaveText("Browse Geographic Regions | Browse Empires & Eras");
  await expect(page.locator("h2.section-heading.browse").locator("a")).toHaveAttribute('href', /\/eras/);

  await expect(page.locator("#map")).toBeVisible();
  // TODO test that items actually show up on the map
  await page.locator('.afghanistan').click();
  await page.locator('#map').getByRole('link', { name: 'Afghanistan' }).click();
  await expect(page.locator("h2.search-heading")).toHaveText("Advanced Search", {timeout: 30000});
  // TODO fix documents - counts are right but individual docs not showing up
  await expect(page.locator("span.count")).toHaveText("0 results");
  let filter_afghanistan = page.getByText('Region: Afghanistan');
  await expect(filter_afghanistan).toBeVisible();

  await page.goto('http://localhost:3000/regions', { timeout: 120000 });
  let table_headings = ["", "ContemporaryPrimarySources", "SourcesBySchool", "ExpertAnalysis", "OtherLegalDocuments", "SpecialCollections"];
  let table = page.locator("table.browse-table");
  await expect(table.locator("th[scope='col']")).toHaveCount(6);
  for (let i = 0; i < table_headings.length; i++) {
    await expect(table.locator("th[scope='col']:nth-child(" + (i+1) + ")")).toHaveText(table_headings[i]);
  }

  // There should be at least 300 rows in the table
  const rowCount = await page.$$eval(`table.browse-table tr`, (rows) => rows.length);
  expect(rowCount).toBeGreaterThan(300);

  // Regions
  let regions = ["Africa", "America", "Asia", "Europe", "IGOs", "Middle East"];
  // Within the table, there should be a row tr with 'data-depth="0"' for each region
  for (let i = 0; i < regions.length; i++) {
    // await expect(table.locator("tr[data-depth='0']")).toHaveText(regions[i]);
    const regionExists = await page.waitForSelector(`tr[data-depth='0']:has-text("${regions[i]}")`);
    expect(regionExists).toBeTruthy();
  }
  let subregions = ["Central Africa", "East Africa", "North Africa", "Southern Africa", "West Africa", "Central America & Caribbean", "North America", "South America", "Central & Western Asia", "East Asia", "South Asia", "Southeast Asia", "The Pacific", "Central & Eastern Europe", "Western Europe"];
  // Within the table, there should be a row tr with 'data-depth="1"' for each subregion
  for (let i = 0; i < subregions.length; i++) {
    // await expect(table.locator("tr[data-depth='1']")).toHaveText(subregions[i]);
    const subregionExists = await page.waitForSelector(`tr[data-depth='1']:has-text("${subregions[i]}")`);
    expect(subregionExists).toBeTruthy();
  }

  // Test that links work
  await page.getByRole('link', { name: 'Africa', exact: true }).click();
  await expect(page.locator("h2.search-heading")).toHaveText("Advanced Search", { timeout: 30000 });
  // TODO fix documents - counts are right but individual docs not showing up
  await expect(page.locator("span.count")).toHaveText("0 results");
  let filter_africa = page.getByText('Region: Africa');
  await expect(filter_africa).toBeVisible();
});
