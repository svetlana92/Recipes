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


    pdf.repeat(:all) do
      pdf.image "#{Rails.root}/public/images/jgive_logo_color.png", width: 150, position: :center
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 40], width: pdf.bounds.width, position: :center do
        pdf.move_down(5)
        pdf.text %q(2001) +
                 %q(‫בקשה‪ ‬זו‪ ‬הוגשה‪ ‬ע"י‪ ‬הנישום‪ ,‬בצורה‪ ‬ממוחשבת‪ ‬בהתאם‪ ‬לחוק‪ ‬חוק‪ ‬חתימה‪ ‬אלקטרונית‪ ,‬תשס"א­‬), size: 10, align: :center
        pdf.text %q[‫באמצעות‪ ‬אתר‪ JGIVE.CO.IL ‬המופעל‪ ‬ע"י‪ ‬קרן‪ ‬עשור‪) ‬ע"ר(‬], size: 10, align: :center
      end
    end

    pdf.bounding_box([ pdf.bounds.left, pdf.bounds.top - 90], width: pdf.bounds.width, height: pdf.bounds.height - 150) do
      pdf.text_direction = :rtl

      pdf.text %q(בס"ד), indent_paragraphs: 16

      pdf.text DateConverter.gregorian_to_hebrew, align: :left
      pdf.move_down(2)
      pdf.text options[:current_date], align: :left, direction: :ltr

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

      pdf.formatted_text [ { text: %q(‫הנדון‪ :‬בקשה לזיכוי מס בגין תרומות ‬עבור‬) +
                                   options[:name] +
                                   %q(‫ת.ז.‬‬) +
                                   options[:taxpayer_id].reverse,
                             styles: [:bold, :underline]
                           }
                         ],
                         align: :center
      pdf.move_down(5)

      first_table = [
        [ options[:current_date].reverse, %q(תאריך הגשת הבקשה), options[:name], %q(שם ‬הנישום)],
        [ options[:company_name], %q(‫שם ‬המעסיק‬), options[:taxpayer_id].reverse, %q(‫ת.ז.‬‬)],
        [ options[:company_number].reverse, %q(‫ח.פ.‬‬), options[:tax_year].reverse, %q(‫שנת ‬המס‬)],
        [ options[:company_deductions].reverse, %q(‫מספר תיק ‬ניכויים‬), options[:address], %q(‫כתובת ‬הנישום‬)],
        ["", "", options[:number_of_applications].reverse, %q(מספר הבקשה בשנת ‬המס)]
      ]
      pdf.table(first_table,
                width: 525,
                cell_style: { border_width: 1,
                              inline_format: true,
                              overflow: :shrink_to_fit })
      pdf.move_down(20)
      pdf.text %q(‫המס בשנת שתרם הנישום‬ של התרומות פירוט להלן‬) +
               %q(2016).reverse +
               %q(‫ס' לפי בתוקף תרומות אישור אלו למוסדות,‬‬) +
               %q(46).reverse + %q(‫לפקודה:‬‬)
      pdf.move_down(20)

      second_table = [
        [ %q(‫סכום התרומה‬), %q(‫תאריך‬), %q(מספר קבלה‬), %q(‫מספר תיק במס‬ הכנסה), %q(שם המוסד), "" ],
      ]
      second_table += options[:payments].each_with_index.map do |payment, index|
        [ payment[:amount].reverse, payment[:date].reverse, payment[:invoice_number].reverse, payment[:charity_number].reverse, payment[:charity_name], (index + 1).to_s.reverse ]
      end
      last_cell = { content: %q(סך תרומות לבקשה זו), colspan: 5, align: :center }
      second_table += [
        [ options[:total_donations].reverse, last_cell ]
      ]
      pdf.table(second_table,
                width: 525,
                cell_style: { border_width: 1,
                              inline_format: true,
                              overflow: :shrink_to_fit })
      pdf.move_down(10)

      pdf.formatted_text [{
                            text: %q(‫להלן פירוט התרומות של הנ"ל,‬ שנתרמו בשנת המס‬) +
                                  %q(2016).reverse +
                                  %q(:),
                            styles: [:underline]
                          }], indent_paragraphs: 16
      pdf.move_down(10)

      pdf.text %q(‫מצ"ב‫:‬‬), indent_paragraphs: 16
      step_one = { content: %q(‫טופס‬) +
                            %q(116).reverse +
                            %(‫מלא‬.)}
      step_two = { content:  %q(‫אישור‪ ‬מעסיק‪ ‬או‪ ‬תלוש‪ ‬שכר.‬‬) }
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

      pdf.move_down(30)
      pdf.text %q(‫חותמת מקורית של‬) +
               %q(JGIVE).reverse +
               %q(‫על קבילות המסמך‬), indent_paragraphs: 16
    end

    pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 14], width: pdf.bounds.width, position: :center do
      pdf.number_pages "‫עמוד‬ <page> ‫מתוך‬ <total>", { start_count_at: 1,
                                                    align: :center,
                                                    size: 10}
    end
    pdf.render_file "assignment.pdf"
    true
  end
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
#     total_donations: '546',
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
