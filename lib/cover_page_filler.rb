require 'combine_pdf'
require 'prawn'
require 'prawn/table'

class CoverPageFiller

  def self.generate_file(options = {})
    pdf = Prawn::Document.new
    pdf.font_families.update(
       "Open Sans Hebrew" => {
       normal: "#{Rails.root}/app/assets/fonts/OpenSansHebrew-Regular.ttf",
       bold: "#{Rails.root}/app/assets/fonts/OpenSansHebrew-Bold.ttf"
       }
      )
    pdf.font("Open Sans Hebrew")
    pdf.text_direction = :rtl

    pdf.move_down(50)
    pdf.text %q(בס"ד), indent_paragraphs: 16

    pdf.text %q(א' בתמוז, תשע"ו), align: :left
    pdf.text "7 June 2016", align: :left

    pdf.move_down(20)
    pdf.text %q(לכבוד), indent_paragraphs: 16
    pdf.move_down(2)
    pdf.text %q(פקיד שומה 3 ירושלים), indent_paragraphs: 16
    pdf.move_down(2)
    pdf.text %q(רשות המיסים בישראל), indent_paragraphs: 16
    pdf.move_down(2)
    pdf.text %q(ג.א.נ.), indent_paragraphs: 16
    pdf.move_down(2)
    pdf.text %q(שלום רב,), indent_paragraphs: 16
    pdf.move_down(10)

    pdf.formatted_text [ { text: %q(‫הנדון‪ :‬בקשה‪ ‬לזיכוי‪ ‬מס‪ ‬בגין‪ ‬תרומות‪ ‬עבור‬) +
                                 options[:name] +
                                 %q(‫ת‪.‬ז‪.‬‬) +
                                 options[:taxpayer_id],
                           styles: [:bold, :underline]
                         }
                       ],
                       align: :center
    pdf.move_down(5)
    first_table = [
      [ options[:current_date], %q(תאריך הגשת הבקשה), options[:name], %q(שם‪ ‬הנישום)],
      [ options[:company_name], %q(‫שם‪ ‬המעסיק‬), options[:taxpayer_id], %q(‫ת‪.‬ז‪.‬‬)],
      [ options[:company_number], %q(‫ח‪.‬פ‪.‬‬), options[:tax_year], %q(‫שנת‪ ‬המס‬)],
      [ options[:company_deductions], %q(‫מספר‪ ‬תיק‪ ‬ניכויים‬), options[:address], %q(‫כתובת‪ ‬הנישום‬)],
      ["", "", options[:number_of_applications], %q(מספר‪ ‬הבקשה ‫בשנת ‬המס)]
    ]
    pdf.table(first_table,
              width: 525,
              cell_style: { border_width: 1,
                            inline_format: true,
                            overflow: :shrink_to_fit })
    pdf.move_down(20)

    pdf.text "להלן פירוט התרומות של הנישום שתרם בשנת המס 2016, למוסדות אלו אישור תרומות בתוקף לפי ס' 46 לפקודה:", indent_paragraphs: 16

    pdf.move_down(20)

    second_table = [
      [ %q(‫סכום התרומה‬), %q(‫תאריך‬), %q(מספר קבלה‬), %q(‫מספר תיק במס‬ הכנסה), %q(שם המוסד), "" ],
    ]
    second_table += options[:payments].each_with_index.map do |payment, index|
      [ payment[:amount], payment[:date], payment[:invoice_number], payment[:charity_number], payment[:charity_name], (index + 1).to_s ]
    end
    last_cell = { content: %q(סך תרומות לבקשה זו), colspan: 5, align: :center }
    second_table += [
      [%q(450), last_cell ]
    ]
    pdf.table(second_table,
              width: 525,
              cell_style: { border_width: 1,
                            inline_format: true,
                            overflow: :shrink_to_fit })
    pdf.move_down(10)

    pdf.formatted_text [{
                          text: %q(להלן פירוט התרומות של ‬הנ"ל‪ ,‬שנתרמו בשנת המס 2016‬‬:),
                          styles: [:underline]
                        }], indent_paragraphs: 16
    pdf.move_down(10)

    pdf.text %q(‫מצ"ב‫:‬‬), indent_paragraphs: 16
    step_one = { content: "‫טופס‪ 116 ‬מלא‪.‬‬" }
    step_two = { content:  %q(‫אישור‪ ‬מעסיק‪ ‬או‪ ‬תלוש‪ ‬שכר‪.‬‬) }
    step_three = { content: %q(‫קבלות‪ ‬מקור‪ ‬בגין‪ ‬התרומות‪ ‬הנ"ל‪.‬‬) }
    step_four = { content: %q(נחתמה‪ ‬דיגיטלית‪ ‬הצהרת‪ ‬הנישום‪ ‬כי‪ ‬הינו‪ ‬מאשר‪ ‬כי‪ ‬תרם‪ ‬את‪ ‬התרומות‪ ‬למוסדות‪ ‬הנ"ל‪ ‬ולא‪ ‬קיבל‬ ‫תמורה‪ ‬בגינן‪.‬‬) }

    list_data = [ [step_one, "1."],
                  [step_two, "2."],
                  [step_three, "3."],
                  [step_four, "4."]
                ]
    pdf.table(list_data,
              width: 525,
              cell_style: { border_width: 0, inline_format: true })

    pdf.page_count.times do |i|
      pdf.go_to_page i
      pdf.image "#{Rails.root}/public/images/jgive_logo_color.png", width: 150, position: :center
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 25], width: pdf.bounds.width, position: :center do
        pdf.move_down(5)
        pdf.text "And here's a sexy footer", size: 16
      end
    end

    pdf.render_file "assignment.pdf"
    true
  end

  # CoverPageFiller.generate_file({
  #     name: 'Gosho Goshev',
  #     current_date: "21.08.2016",
  #     taxpayer_id: '123456789',
  #     tax_year: '2016',
  #     company_name: 'Something',
  #     company_number: '123456789',
  #     company_deductions: '325153153',
  #     address: 'dsjhfdjs jkfds jkf',
  #     number_of_applications: '2',
  #
  #     payments: [
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #       {
  #         amount: '2112',
  #         date: '21.05.2016',
  #         invoice_number: '950001',
  #         charity_number: '2315156151',
  #         charity_name: 'sdsad'
  #       },
  #     ]
  # })


end
