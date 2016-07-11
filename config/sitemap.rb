# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = A9n.app_host

# The remote host where your sitemaps will be hosted
# sm_host_path = "https://#{A9n.aws[:bucket_name]}.s3.amazonaws.com"
# SitemapGenerator::Sitemap.sitemaps_host = sm_host_path

# The directory to write sitemaps to locally
# SitemapGenerator::Sitemap.public_path = 'tmp'

# Directory/path if we don't want to upload to the root of sitemaps_host
# SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

# SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

# To disable all non-essential output
SitemapGenerator.verbose = false

# To always create an index
# SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add about_us_path, priority: 0.1
  add contact_us_path, priority: 0.1
  add terms_path, priority: 0.1
  # add posts_path, changefreq: 'weekly'
  add Sim::Routes.user_session_path, priority: 0.0
  add Sim::Routes.new_user_registration_path, priority: 0.0

  Product.find_each do |p|
    add "#{Sim::Routes.html_product_path(p.id)}",
        priority: 1.0, changefreq: 'daily', lastmod: p.updated_at
  end
  Service.find_each do |s|
    add "#{Sim::Routes.html_service_path(s.id)}",
        priority: 1.0, changefreq: 'daily', lastmod: s.updated_at
  end
  Business.find_each do |b|
    add "#{Sim::Routes.business_show_path}#{b.id}",
        priority: 1.0, changefreq: 'daily', lastmod: b.updated_at
  end
  # Product categories
  Category.where(type: 'ProductCategory').find_each do |ct|
    c = CategoryTranslation.where(category_id: ct.id, locale: 'en')
    name = ERB::Util.url_encode(c[0].value)
    add "#{Sim::Routes.product_category_path}#{name}",
        priority: 1.0, changefreq: 'daily', lastmod: c[0].updated_at
  end
  # Service categories
  Category.where(type: 'ServiceCategory').find_each do |ct|
    c = CategoryTranslation.where(category_id: ct.id, locale: 'en')
    name = ERB::Util.url_encode(c[0].value)
    add "#{Sim::Routes.service_category_path}#{name}",
        priority: 1.0, changefreq: 'daily', lastmod: c[0].updated_at
  end
end
