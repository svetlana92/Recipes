require 'combine_pdf'
require 'prawn'

class PdfFiller
  PDF_WIDTH = 560
  PDF_HEIGHT = 857
  TEMPLATE = {
    name: "1161.pdf",
    field_options: [
      {
        year: { x: 372, y: 147, width: 65, height: 13, character_spacing: 9 },

        user_id: { x: 157, y: 194, width: 100, height: 13, character_spacing: 4 },
        last_name: { x: 319, y: 194, width: 159, height: 13 },
        first_name: { x: 478, y: 194, width: 159, height: 13 },
        date_of_birth: { x: 567, y: 194, width: 90, height: 13, character_spacing: 4 },

        street: { x: 283, y: 221, width: 225, height: 13 },
        street_number: { x: 314, y: 221, width: 30, height: 13 },
        city: { x: 387, y: 221, width: 72, height: 13 },
        zip_code: { x: 442, y: 221, width: 55, height: 13, character_spacing: 4 },
        phone_number: { x: 530, y: 221, width: 85, height: 13 },
        phone_code: { x: 568, y: 221, width: 30, height: 13 },

        male: { x: 77, y: 253, width: 11, height: 13, size: 9 },
        female: { x: 116, y: 253, width: 11, height: 13, size: 9 },
        single: { x: 170, y: 253, width: 11, height: 13, size: 9 },
        married: { x: 229, y: 253, width: 11, height: 13, size: 9 },
        divorced: { x: 293, y: 253, width: 11, height: 13, size: 9 },
        widower: { x: 353, y: 253, width: 11, height: 13, size: 9 },
        israeli_citizen_yes: { x: 416, y: 254, width: 11, height: 13, size: 9 },
        israeli_citizen_no: { x: 456, y: 254, width: 11, height: 13, size: 9 },

        child_mark_1: { x: 67, y: 390, width: 11, height: 13 },
        child_name_1: { x: 140, y: 390, width: 72, height: 13 },
        child_id_1: { x: 238, y: 390, width: 97, height: 13, character_spacing: 4 },
        child_date_of_birth_1: { x: 308, y: 390, width: 67, height: 13, character_spacing: 4 },

        child_mark_2: { x: 67, y: 410, width: 11, height: 13 },
        child_name_2: { x: 140, y: 410, width: 72, height: 13 },
        child_id_2: { x: 238, y: 410, width: 97, height: 13, character_spacing: 4 },
        child_date_of_birth_2: { x: 308, y: 410, width: 67, height: 13, character_spacing: 4 },

        child_mark_3: { x: 67, y: 430, width: 11, height: 13 },
        child_name_3: { x: 140, y: 430, width: 72, height: 13 },
        child_id_3: { x: 238, y: 430, width: 97, height: 13, character_spacing: 4 },
        child_date_of_birth_3: { x: 308, y: 430, width: 67, height: 13, character_spacing: 4 },

        child_mark_4: { x: 67, y: 450, width: 11, height: 13 },
        child_name_4: { x: 140, y: 450, width: 72, height: 13 },
        child_id_4: { x: 238, y: 450, width: 97, height: 13, character_spacing: 4 },
        child_date_of_birth_4: { x: 308, y: 450, width: 67, height: 13, character_spacing: 4 },

        child_mark_5: { x: 67, y: 470, width: 11, height: 13 },
        child_name_5: { x: 140, y: 470, width: 72, height: 13 },
        child_id_5: { x: 238, y: 470, width: 97, height: 13, character_spacing: 4 },
        child_date_of_birth_5: { x: 308, y: 470, width: 67, height: 13, character_spacing: 4 },

        child_mark_6: { x: 326, y: 390, width: 11, height: 13 },
        child_name_6: { x: 398, y: 390, width: 72, height: 13 },
        child_id_6: { x: 497, y: 390, width: 98, height: 13, character_spacing: 4 },
        child_date_of_birth_6: { x: 566, y: 390, width: 67, height: 13, character_spacing: 4 },

        child_mark_7: { x: 326, y: 410, width: 11, height: 13 },
        child_name_7: { x: 398, y: 410, width: 72, height: 13 },
        child_id_7: { x: 497, y: 410, width: 98, height: 13, character_spacing: 4 },
        child_date_of_birth_7: { x: 566, y: 410, width: 67, height: 13, character_spacing: 4 },

        child_mark_8: { x: 326, y: 430, width: 11, height: 13 },
        child_name_8: { x: 398, y: 430, width: 72, height: 13 },
        child_id_8: { x: 497, y: 430, width: 98, height: 13, character_spacing: 4 },
        child_date_of_birth_8: { x: 566, y: 430, width: 67, height: 13, character_spacing: 4 },

        child_mark_9: { x: 326, y: 450, width: 11, height: 13 },
        child_name_9: { x: 398, y: 450, width: 72, height: 13 },
        child_id_9: { x: 497, y: 450, width: 98, height: 13, character_spacing: 4 },
        child_date_of_birth_9: { x: 566, y: 450, width: 67, height: 13, character_spacing: 4 },

        child_mark_10: { x: 326, y: 470, width: 11, height: 13 },
        child_name_10: { x: 398, y: 470, width: 72, height: 13 },
        child_id_10: { x: 497, y: 470, width: 98, height: 13, character_spacing: 4 },
        child_date_of_birth_10: { x: 566, y: 470, width: 67, height: 13, character_spacing: 4 },

        type_of_income_1: { x: 114, y: 571, width: 55, height: 13 },
        employer_name_1: { x: 221, y: 571, width: 107, height: 13 },
        file_number_1: { x: 290, y: 571, width: 69, height: 13 },

        type_of_income_2: { x: 114, y: 591, width: 55, height: 13 },
        employer_name_2: { x: 221, y: 591, width: 107, height: 13 },
        file_number_2: { x: 290, y: 591, width: 69, height: 13 },

        type_of_income_3: { x: 114, y: 611, width: 55, height: 13 },
        employer_name_3: { x: 221, y: 611, width: 107, height: 13 },
        file_number_3: { x: 290, y: 611, width: 69, height: 13 },

        type_of_income_4: { x: 114, y: 631, width: 55, height: 13 },
        employer_name_4: { x: 221, y: 631, width: 107, height: 13 },
        file_number_4: { x: 290, y: 631, width: 69, height: 13 },

        type_of_income_5: { x: 114, y: 651, width: 55, height: 13 },
        employer_name_5: { x: 221, y: 651, width: 107, height: 13 },
        file_number_5: { x: 290, y: 651, width: 69, height: 13 },

        type_of_income_6: { x: 114, y: 670, width: 55, height: 13 },
        employer_name_6: { x: 221, y: 670, width: 107, height: 13 },
        file_number_6: { x: 290, y: 670, width: 69, height: 13 },
      },
      {
        amount_of_donations: { x: 331, y: 199, width: 69, height: 13 },
        always_check: { x: 41, y: 198, width: 11, height: 13 },
        date: { x: 175, y: 816, width: 87, height: 13 },
      }
    ]
  }

  def self.fill(pages = [])
    keys_match = pages.map(&:keys) == TEMPLATE[:field_options].map(&:keys)
    fail ArgumentError.new("Not supported text.") unless keys_match

    prawn_pdf = Prawn::Document.new do |new_pdf|
      new_pdf.font_families.update(
         "DejaVu Sans" => {
         :normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf"
         }
        )
      new_pdf.text_direction = :rtl
      new_pdf.font("DejaVu Sans") do
        pages.each_with_index do |texts, index|
          texts.each do |key, value|
            fill_text(new_pdf, value, TEMPLATE[:field_options][index][key])
          end
          new_pdf.start_new_page
        end
      end
    end

    pdf_data = prawn_pdf.render
    pdf = CombinePDF.parse(pdf_data)
    template = CombinePDF.load TEMPLATE[:name]
    template.pages.each_with_index do |page, index|
      page << pdf.pages[index]
    end
    
    file = StringIO.new(template.to_pdf)
    file.class.class_eval { attr_accessor :original_filename, :content_type }
    file.original_filename = "Latest Tax Refund"
    file.content_type = "application/pdf"
    file
  end

  private

  def self.top_right_coordinates(x,y)
    [(PDF_WIDTH - x), (PDF_HEIGHT - y)]
  end

  def self.fill_text(pdf, text, options = {})
    options[:at] = top_right_coordinates(options.delete(:x), options.delete(:y))
    options[:align] = :center
    options[:valign] = :center
    options[:overflow] = :shrink_to_fit
    pdf.text_box text, options.merge(overflow: :shrink_to_fit, disable_wrap_by_char: false)
  end
end
