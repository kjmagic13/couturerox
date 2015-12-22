Jekyll::Hooks.register :site, :after_reset do |site|
	# code to call before Jekyll renders the site
	storenvy = Storenvy.new(site)
	storenvy.generate_theme
end


class	Storenvy

	def initialize(site)
		@project_path = site.source
		@layout_file_name = "default.html"
		@read_dir = "pages"
		@write_dir = "storenvy"

		# @storenvy_url = "https://kaymic.storenvy.com"
		# @storenvy_user = ""
		# @storenvy_pass = ""

		@storenvy_pages = {
			layout: 			true,
			home: 			5326650,
			collection: 	5326653,
			product: 		5326656,
			contact: 		5326659,
			faq: 				5326662,
			# maintenance: 	5326665,
			maintenance: 	5326665,
			custom: 			false
		}

		@replace_with_arr = [
			['{{ site.baseurl }}', 'http://kaymic.com/couturerox'],
			['{{ content }}', '{{ page_content }}'],
			['site.title', 'store.name'],
			['page.path == \'pages/home.html\'', 'page.name == \'Home\''],
			['if site.data.products', 'if products.current != blank'],
			['product in site.data.products', 'product in products.current'],
			['collection in site.data.collections', 'collection in collections.nav'],
			['page in site.data.pages', 'page in pages.all'],
			['site.banner_url | prepend: site.baseurl', 'site.banner_url'],
		]
	end

	def generate_theme
		puts "Generating Storenvy Theme"

		FileUtils.rm_rf Dir.glob("#{@project_path}/#{@write_dir}/*")

		File.open("#{@project_path}/_layouts/#{@layout_file_name}", 'r') do |f|
			write_file f
		end

		Dir.glob("#{@project_path}/#{@read_dir}/*.html") do |file_path|
			File.open(file_path, 'r') do |f|
				write_file f
			end
		end
	end

	private

	def write_file(f)
		basename = @layout_file_name == File.basename(f) ? 'layout.html' : File.basename(f)
		File.open("#{@project_path}/#{@write_dir}/#{basename}", 'w+') do |w|
			w.write manipulate_file(f.read)
		end
	end

	def manipulate_file(contents)
		index = contents.index("---", 1)
		contents = contents[index+4..-1] if index
		contents = include_files contents
		@replace_with_arr.each do |item|
			contents.gsub!(item[0], item[1])
		end
		contents
	end

	def include_files(contents)
		match_str = /\{%.*include.(.*\S).*%\}/
		while contents.scan(match_str).any?
			contents.gsub!(match_str) do
				filepath = "#{@project_path}/_includes/#{$1}"
				File.read(filepath) if File.exist?(filepath)
			end
		end
		contents
	end

end
