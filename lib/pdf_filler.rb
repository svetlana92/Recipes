require 'combine_pdf'
require 'prawn'

class PdfFiller
  PDF_WIDTH = 560
  PDF_HEIGHT = 857
  TEMPLATE = {
    name: "1161.pdf",
    field_options: {
      first_name: { x: 503, y: 194, width: 225, height: 15 },
      last_name: { x: 353, y: 194, width: 225, height: 15 },
      city: { x: 460, y: 220, width: 225, height: 15 },
      street_number: { x: 410, y: 220, width: 225, height: 15 },
      street: { x: 283, y: 220, width: 225, height: 15 },
      year: { x: 451, y: 148, width: 225, height: 15, character_spacing: 8 },
      date_of_birth: { x: 634, y: 194, width: 225, height: 15, character_spacing: 5 },
      user_id: { x: 218, y: 194, width: 225, height: 15, character_spacing: 5 },
      zip_code: { x: 526, y: 220, width: 225, height: 15, character_spacing: 5 },
      # child_name: { x: 220, y: 194, width: 225, height: 15 }
    }
  }
  OUTPUT = "New.pdf"

  def self.fill(texts = {})
    fail ArgumentError.new("Not supported text.") if texts.keys != TEMPLATE[:field_options].keys
    prawn_pdf = Prawn::Document.new do |new_pdf|
      new_pdf.font_families.update(
         "DejaVu Sans" => {
         :normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf"
         }
        )
      new_pdf.text_direction = :rtl
      new_pdf.font("DejaVu Sans") do
        texts.each do |key, value|
          fill_text(new_pdf, value, TEMPLATE[:field_options][key])
        end
      end
    end
    pdf_data = prawn_pdf.render
    pdf = CombinePDF.parse(pdf_data).pages[0]
    template = CombinePDF.load TEMPLATE[:name]
    template.pages[0] << pdf
    template.save OUTPUT
  end

  private

  def self.top_right_coordinates(x,y)
    [(PDF_WIDTH - x), (PDF_HEIGHT - y)]
  end

  def self.fill_text(pdf, text, options = {})
    options[:at] = top_right_coordinates(options.delete(:x), options.delete(:y))
    options[:align] = :center
    pdf.text_box text, options
  end
end
