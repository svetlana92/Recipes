require 'combine_pdf'
require 'prawn'
require 'prawn/table'

class CoverPageFiller

  # CoverPageFiller.generate_file

  def self.generate_file
    pdf = Prawn::Document.new
    pdf.font_families.update(
       "Open Sans Hebrew" => {
       normal: "#{Rails.root}/app/assets/fonts/OpenSansHebrew-Regular.ttf",
       bold: "#{Rails.root}/app/assets/fonts/OpenSansHebrew-Bold.ttf"
       }
      )
    pdf.font("Open Sans Hebrew")
    pdf.text_direction = :rtl
    pdf.image "#{Rails.root}/public/images/jgive_logo_color.png", width: 150, position: :center
    pdf.pad_top(50) do
      pdf.text %q(בס"ד)
    end
    pdf.text %q(‏א' בתמוז, תשע"ו), align: :left
    pdf.text "7 June 2016", align: :left
    pdf.move_down(20)
    pdf.text %q(לכבוד)
    pdf.move_down(2)
    pdf.text %q(שם פרטי ומשפחה של התורם)
    pdf.move_down(2)
    pdf.text %q(שלום רב,)
    pdf.move_down(2)
    pdf.formatted_text [ { text: "הנדון: בקשה לזיכוי מס בגין תרומות",
                           styles: [:bold, :underline]
                         }
                       ],
                       align: :center
    pdf.move_down(10)
    pdf.formatted_text [{ text: "אנו שמחים שבחרת ב-Jgive כפלטפורמת התרומות שלך. במספר צעדים פשוטים תוכלו בקלות ובנוחות לקבל את זיכוי המס עבור התרומות שבוצעו בפלטפורמה:",
                          styles: [:underline] }]
    pdf.move_down(10)
    step_one = { content: "אתרו את פקיד השומה הרלוונטי לאזור מגורכם " +
                          "<u><link href='https://taxes.gov.il/Pages/InfoTaxesGovIl/TaxesUnits.aspx'>בלינק זה" +
                          "</link></u>",
                 colspan: 2 }
    step_two = { content:  "חתמו בתחתית טופס 116 במקום המיועד לחתימה.",
                 colspan: 2 }
    step_three = { content: %q(הגישו את המסמכים הבאים לפקיד השומה (מומלץ לגשת פיזית לפקיד השומה ולקבל חותמת "נתקבל"):),
                   colspan: 2 }
    step_three_a_content = { content: "טופס 116 (נשלח במייל זה)",
                             width: 484 }
    step_three_a = { content: "a.",
                     width: 20 }
    step_four = { content: "קובץ ריכוז קבלות מקוריות (נשלחו במייל זה)",
                  colspan: 2 }
    step_five = { content: "תלוש שכר אחרון (במקרה של מספר מעסיקים – תלוש שכר מכל מעסיק)",
                  colspan: 2 }
    step_six = { content: %q(חשוב לציין, אם ברצונכם להגיש את הבקשה במסגרת הטופס המצורף למייל זה, עליכם להגיש את הבקשה במהלך שנת המס בה נתרמו התרומות (2016), אחרת יהיה עליכם להגיש את הבקשה במסגרת דו"ח שנתי לאחר סיום שנת המס.),
                 colspan: 2 }
    list_data = [ [step_one, "1."],
                  [step_two, "2."],
                  [step_three, "3."],
                  [step_three_a_content, step_three_a, "" ],
                  [step_four, "4."],
                  [step_five, "5."],
                  [step_six, "6."],
                ]
    pdf.table(list_data,
              width: 525,
              cell_style: { border_width: 0, inline_format: true })


    pdf.render_file "assignment.pdf"
    true
  end
end
