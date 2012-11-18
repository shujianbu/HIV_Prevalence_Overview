require 'country_iso_translater'

class GoogleVisualizationMapFormat
	attr_accessor :name, :value, :displayname
end

class GoogleVisualizationLinechartHeader
	attr_accessor :id, :label, :type
	def initialize(id, label, type)
		@id = id
		@label = label
		@type = type
	end
end

class GoogleVisualizationLinechartBody
	attr_accessor :c
	def initialize(c)
		@c = c
	end
end

class GoogleVisualizationLinechartBodyEntry
	attr_accessor :v
	def initialize(v)
		@v = v
	end
end

class GoogleVisualizationLinchartFormat
	attr_accessor :cols, :rows
	def initialize(cols, rows)
		@cols = cols
		@rows = rows
	end
end

class HivdatafetcherController < ApplicationController
	def index
		if params[:factor].nil? and params[:year].nil? and (not params[:country].nil?)
			@count_name = SunDawg::CountryIsoTranslater.translate_iso3166_alpha2_to_alpha3(params[:country])
			@data_header = Array.new
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'year', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'hiv', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'gdp', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'healthexpenditure', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'improvedwatersource', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'ruralpopulation', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'unemploymentrate', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'literacyrate', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'improvedsanitationfacilities', 'number'))


			@data_body = Array.new
			@col = Array.new
			@col[0] = Hiv.all(:country => @count_name).to_a
			@col[1] = Gdp.all(:country => @count_name).to_a
			@col[2] = HealthExpenditure.all(:country => @count_name).to_a
			@col[3] = ImprovedWaterSource.all(:country => @count_name).to_a
			@col[4] = RuralPopulation.all(:country => @count_name).to_a
			@col[5] = UnemploymentRate.all(:country => @count_name).to_a
			@col[6] = LiteracyRate.all(:country => @count_name).to_a
			@col[7] = ImprovedSanitationFacilities.all(:country => @count_name).to_a

			@col[0].length.times do |i|
				@data_body[i] = GoogleVisualizationLinechartBody.new(Array.new)

				@data_body[i].c<< (GoogleVisualizationLinechartBodyEntry.new(@col[0][i].year.to_i))
				8.times do |j|
					if @col[j][i].value.nil?
						@data_body[i].c<<(GoogleVisualizationLinechartBodyEntry.new(0))
					else
						@data_body[i].c<<(GoogleVisualizationLinechartBodyEntry.new(@col[j][i].value.to_f))
					end
				end
			end
			@data_pack = GoogleVisualizationLinchartFormat.new(@data_header, @data_body)
		elsif (not params[:factor].nil?) and params[:year].nil? and (not params[:country].nil?)
			@count_name = SunDawg::CountryIsoTranslater.translate_iso3166_alpha2_to_alpha3(params[:country])
			@data_header = Array.new
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'year', 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', params[:factor], 'number'))
			@data_header<<(GoogleVisualizationLinechartHeader.new('', 'country', 'string'))

			case params[:factor]
				when 'gdp'
					@uni = Gdp.all(:country => @count_name).to_a
				when 'healthexpenditure'
					@uni = HealthExpenditure.all(:country => @count_name).to_a
				when 'improvedwatersource'
					@uni = ImprovedWaterSource.all(:country => @count_name).to_a
				when 'ruralpopulation'
					@uni = RuralPopulation.all(:country => @count_name).to_a
				when 'unemploymentrate'
					@uni = UnemploymentRate.all(:country => @count_name).to_a
				when 'literacyrate'
					@uni = LiteracyRate.all(:country => @count_name).to_a
				when 'improvedsanitationfacilities'
					@uni = ImprovedSanitationFacilities.all(:country => @count_name).to_a
				when 'hiv'
					@uni = Hiv.all(:country => @count_name).to_a
			end

			@data_body = Array.new

			@uni.length.times do |i|
				@data_body[i] = GoogleVisualizationLinechartBody.new(Array.new)
				@data_body[i].c<< (GoogleVisualizationLinechartBodyEntry.new(@uni[i].year.to_i))
				@data_body[i].c<< (GoogleVisualizationLinechartBodyEntry.new(@uni[i].value.to_f))
				@data_body[i].c<< (GoogleVisualizationLinechartBodyEntry.new(params[:country].to_s))

			end
			@data_pack = GoogleVisualizationLinchartFormat.new(@data_header, @data_body)
		else

		unless params[:year].nil? and params[:factor].nil?
			case params[:factor]
				when 'gdp'
					@uni = Gdp.all(:year => params[:year])
				when 'healthexpenditure'
					@uni = HealthExpenditure.all(:year => params[:year])
				when 'improvedwatersource'
					@uni = ImprovedWaterSource.all(:year => params[:year])
				when 'ruralpopulation'
					@uni = RuralPopulation.all(:year => params[:year])
				when 'unemploymentrate'
					@uni = UnemploymentRate.all(:year => params[:year])
				when 'literacyrate'
					@uni = LiteracyRate.all(:year => params[:year])
				when 'improvedsanitationfacilities'
					@uni = ImprovedSanitationFacilities.all(:year => params[:year])
				when 'hiv'
					@uni = Hiv.all(:year => params[:year])
			end
			@data_pack = Array.new
			@uni.each do |h|
				t = GoogleVisualizationMapFormat.new
				begin
					t.displayname = SunDawg::CountryIsoTranslater.translate_iso3166_alpha3_to_name(h.country)
					t.name = SunDawg::CountryIsoTranslater.translate_iso3166_name_to_alpha2(t.displayname)
					if h.value.nil?
						t.value = 0
					else
						t.value = h.value
					end
					@data_pack.push(t)
					rescue SunDawg::CountryIsoTranslater::NoCountryError
				end
				puts(t.displayname)
				puts(t.value)
			end
		end
		
		if params[:country].nil? and params[:year].nil? and params[:factor].nil?
			@hivs = Hiv.all(:year => "2005")
			@data_pack = Array.new
			@hivs.each do |h|
				t = GoogleVisualizationMapFormat.new
				begin
					t.displayname = SunDawg::CountryIsoTranslater.translate_iso3166_alpha3_to_name(h.country)
					t.name = SunDawg::CountryIsoTranslater.translate_iso3166_name_to_alpha2(t.displayname)
					if h.value.nil?
						t.value = 0
					else
						t.value = h.value
					end
					@data_pack.push(t)
					rescue SunDawg::CountryIsoTranslater::NoCountryError
				end
				puts(t.displayname)
				puts(t.value)
			end
		end

		end


   		respond_to do |format|
    	 		format.html # index.html.erb
    			format.json { render json: @data_pack }
   		end
	end
end

