require 'combine_pdf'
require 'prawn'

class PdfFiller
  PDF_WIDTH = 560
  PDF_HEIGHT = 857
  TEMPLATE = {
    name: "1161.pdf",
    field_options: [
      {
        first_name: { x: 503, y: 194, width: 225, height: 15 },
        last_name: { x: 353, y: 194, width: 225, height: 15 },
        city: { x: 460, y: 220, width: 225, height: 15 },
        street_number: { x: 310, y: 220, width: 125, height: 15 },
        street: { x: 283, y: 220, width: 225, height: 15 },
        year: { x: 451, y: 148, width: 225, height: 15, character_spacing: 8 },
        date_of_birth: { x: 634, y: 194, width: 225, height: 15, character_spacing: 4 },
        user_id: { x: 219, y: 194, width: 225, height: 15, character_spacing: 4 },
        zip_code: { x: 526, y: 220, width: 225, height: 15, character_spacing: 4 },
        phone_number: { x: 606, y: 220, width: 225, height: 15 },
        phone_code: { x: 666, y: 220, width: 225, height: 15 },
        male: { x: 184, y: 255, width: 225, height: 15 },
        female: { x: 222, y: 255, width: 225, height: 15 },
        single: { x: 276, y: 255, width: 225, height: 15 },
        married: { x: 335, y: 255, width: 225, height: 15 },
        divorced: { x: 399, y: 255, width: 225, height: 15 },
        widower: { x: 459, y: 255, width: 225, height: 15 },
        israeli_citizen_yes: { x: 522, y: 255, width: 225, height: 15 },
        israeli_citizen_no: { x: 562, y: 255, width: 225, height: 15 },
        child_mark_1: { x: 174, y: 390, width: 225, height: 15 },
        child_name_1: { x: 215, y: 390, width: 225, height: 15 },
        child_id_1: { x: 302, y: 390, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_1: { x: 387, y: 390, width: 225, height: 15, character_spacing: 4},
        child_mark_2: { x: 174, y: 410, width: 225, height: 15 },
        child_name_2: { x: 215, y: 410, width: 225, height: 15 },
        child_id_2: { x: 302, y: 410, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_2: { x: 387, y: 410, width: 225, height: 15, character_spacing: 4},
        child_mark_3: { x: 174, y: 430, width: 225, height: 15 },
        child_name_3: { x: 215, y: 430, width: 225, height: 15 },
        child_id_3: { x: 302, y: 430, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_3: { x: 387, y: 430, width: 225, height: 15, character_spacing: 4},
        child_mark_4: { x: 174, y: 450, width: 225, height: 15 },
        child_name_4: { x: 215, y: 450, width: 225, height: 15 },
        child_id_4: { x: 302, y: 450, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_4: { x: 387, y: 450, width: 225, height: 15, character_spacing: 4},
        child_mark_5: { x: 174, y: 470, width: 225, height: 15 },
        child_name_5: { x: 215, y: 470, width: 225, height: 15 },
        child_id_5: { x: 302, y: 470, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_5: { x: 387, y: 470, width: 225, height: 15, character_spacing: 4},
        child_mark_6: { x: 433, y: 390, width: 225, height: 15 },
        child_name_6: { x: 473, y: 390, width: 225, height: 15 },
        child_id_6: { x: 560, y: 390, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_6: { x: 645, y: 390, width: 225, height: 15, character_spacing: 4},
        child_mark_7: { x: 433, y: 410, width: 225, height: 15 },
        child_name_7: { x: 473, y: 410, width: 225, height: 15 },
        child_id_7: { x: 560, y: 410, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_7: { x: 645, y: 410, width: 225, height: 15, character_spacing: 4},
        child_mark_8: { x: 433, y: 430, width: 225, height: 15 },
        child_name_8: { x: 473, y: 430, width: 225, height: 15 },
        child_id_8: { x: 560, y: 430, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_8: { x: 645, y: 430, width: 225, height: 15, character_spacing: 4},
        child_mark_9: { x: 433, y: 450, width: 225, height: 15 },
        child_name_9: { x: 473, y: 450, width: 225, height: 15 },
        child_id_9: { x: 560, y: 450, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_9: { x: 645, y: 450, width: 225, height: 15, character_spacing: 4},
        child_mark_10: { x: 433, y: 470, width: 225, height: 15 },
        child_name_10: { x: 473, y: 470, width: 225, height: 15 },
        child_id_10: { x: 560, y: 470, width: 225, height: 15, character_spacing: 4},
        child_date_of_birth_10: { x: 645, y: 470, width: 225, height: 15, character_spacing: 4},
        type_of_income_1: { x: 200, y: 572, width: 225, height: 15 },
        employer_name_1: { x: 281, y: 572, width: 225, height: 15 },
        file_number_1: { x: 370, y: 572, width: 225, height: 15 },
        type_of_income_2: { x: 200, y: 592, width: 225, height: 15 },
        employer_name_2: { x: 281, y: 592, width: 225, height: 15 },
        file_number_2: { x: 370, y: 592, width: 225, height: 15 },
        type_of_income_3: { x: 200, y: 612, width: 225, height: 15 },
        employer_name_3: { x: 281, y: 612, width: 225, height: 15 },
        file_number_3: { x: 370, y: 612, width: 225, height: 15 },
        type_of_income_4: { x: 200, y: 632, width: 225, height: 15 },
        employer_name_4: { x: 281, y: 632, width: 225, height: 15 },
        file_number_4: { x: 370, y: 632, width: 225, height: 15 },
        type_of_income_5: { x: 200, y: 652, width: 225, height: 15 },
        employer_name_5: { x: 281, y: 652, width: 225, height: 15 },
        file_number_5: { x: 370, y: 652, width: 225, height: 15 },
        type_of_income_6: { x: 200, y: 672, width: 225, height: 15 },
        employer_name_6: { x: 281, y: 672, width: 225, height: 15 },
        file_number_6: { x: 370, y: 672, width: 225, height: 15 },
      },
      {
        amount_of_donations: { x: 408, y: 200, width: 225, height: 15 },
        always_check: { x: 148, y: 200, width: 225, height: 15 },
        date: { x: 242, y: 817, width: 225, height: 15 },
      }
    ]
  }
  OUTPUT = "New.pdf"

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
    template.save OUTPUT
  end

  private

  def self.top_right_coordinates(x,y)
    [(PDF_WIDTH - x), (PDF_HEIGHT - y)]
  end

  def self.fill_text(pdf, text, options = {})
    options[:at] = top_right_coordinates(options.delete(:x), options.delete(:y))
    options[:align] = :center
    pdf.text_box text, options.merge(overflow: :shrink_to_fit, disable_wrap_by_char: false)
  end
end
