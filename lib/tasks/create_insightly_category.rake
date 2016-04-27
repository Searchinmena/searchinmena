desc 'Create Insightly categories'
task create_insightly_category: :environment do
  categories = ["Telesales: Phone call", "Telesales: Introduction Email",
                "Telesales: Follow-up", 'Telesales: Meeting',
                "Telesales: Quotation", "Telesales: Invoice"]

  categories.each do |c|
    begin
      InsightlyService::TaskCategory.new(c).perform
    rescue => e
      puts "ERROR:  -> #{e}"
    end
  end

  InsightlyService::OpportunityCategory.new('').perform
end



