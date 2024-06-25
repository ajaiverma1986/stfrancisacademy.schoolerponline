using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ManageDoc
/// </summary>
public class ManageDoc
{
	public ManageDoc()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public class ITextEvents : PdfPageEventHelper
    {
        // This is the contentbyte object of the writer
        PdfContentByte cb;

        // we will put the final number of pages in a template
        PdfTemplate headerTemplate, footerTemplate;

        // this is the BaseFont we are going to use for the header / footer
        BaseFont bf = null;

        // This keeps track of the creation time
        DateTime PrintTime = DateTime.Now;

        #region Fields
        private string _header;
        #endregion

        #region Properties
        public string Header
        {
            get { return _header; }
            set { _header = value; }
        }
        #endregion

        public override void OnOpenDocument(PdfWriter writer, Document document)
        {
            try
            {
                PrintTime = DateTime.Now;
                bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                cb = writer.DirectContent;
                headerTemplate = cb.CreateTemplate(65, 65);
                footerTemplate = cb.CreateTemplate(50, 50);
            }
            catch (DocumentException de)
            {
            }
            catch (System.IO.IOException ioe)
            {
            }
        }

        public override void OnEndPage(iTextSharp.text.pdf.PdfWriter writer, iTextSharp.text.Document document)
        {
            base.OnEndPage(writer, document);
            iTextSharp.text.Font baseFontNormal = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 12f, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
            iTextSharp.text.Font baseFontSmall = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10f, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
            DataUtility objdut = new DataUtility();
            string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+'^'+City+', '+state+', '+Country+', '+pincode+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'')+'^'+isnull(BrName,'')+'^'+isnull(photo,'') from branch_master where brid = " + System.Web.HttpContext.Current.Session["brbrid"] + ""));

            string title = "";
            string ImageUrl = "~/BranchPanel/images/9update.png";
            string addr1 = "";
            string addr2 = "";
            if (branchdata != "")
            {
                string[] getbranchdata = branchdata.Split('^');
                title = getbranchdata[6].ToString();
                addr1 = getbranchdata[0];
                addr2 = getbranchdata[1];

                //string[] getCont;
                //Contact = getbranchdata[2];
                //getCont = Contact.Split(',');
                //Ph = getCont[0].ToString();
                //mobile = getCont[1].ToString();
                //EmailID = getbranchdata[3].ToString();
                //Website = getbranchdata[4].ToString();
                //SchoolAffi = getbranchdata[5].ToString();
                //SpScool.InnerText = getbranchdata[6].ToString();
                //SAddress.InnerText = address;

                //SpFone.InnerText = Ph.ToString();
                //SMobile.InnerText = mobile.ToString();
                //SEmailID.InnerText = EmailID.ToString();

                //if (SchoolAffi != "")
                //{
                //    SchoolAffia.InnerText = SchoolAffi.Trim();
                //    affhead.InnerText = "Affiliation No:";

                //}
                //else
                //{
                //    affhead.InnerText = ".";
                //}
                //SWebsite.InnerText = Website.Trim();
                if (getbranchdata[7].ToString() != "")
                {
                    ImageUrl = System.Web.HttpContext.Current.Server.MapPath("~/BranchPanel/images/") + getbranchdata[7].ToString();
                }
                else
                {
                    ImageUrl = System.Web.HttpContext.Current.Server.MapPath("~/BranchPanel/images/") + "9update.png";
                }
            }
            Phrase p1Header = new Phrase(title, baseFontNormal);

            //Create PdfTable object
            PdfPTable pdfTab = new PdfPTable(3);

            //We will have to create separate cells to include image logo and 2 separate strings
            //Row 1

            PdfPCell pdfCell2 = new PdfPCell(p1Header);
            Phrase p2Header = new Phrase(Convert.ToString(addr1), baseFontSmall);

            PdfPCell pdfCell3 = new PdfPCell(p2Header);
            Phrase p3Header = new Phrase(Convert.ToString(addr2), baseFontSmall);

            PdfPCell pdfCell4 = new PdfPCell(p3Header);
            pdfCell2.Colspan = 3;
            pdfCell3.Colspan = 3;
            pdfCell4.Colspan = 3;
            String text = "Page " + writer.PageNumber + " of ";

            //Add paging to header
            //{
            //    cb.BeginText();
            //    cb.SetFontAndSize(bf, 12);
            //    cb.SetTextMatrix(document.PageSize.GetRight(200), document.PageSize.GetTop(45));
            //    cb.ShowText(text);
            //    cb.EndText();
            //    float len = bf.GetWidthPoint(text, 12);
            //    //Adds "12" in Page 1 of 12
            //    cb.AddTemplate(headerTemplate, document.PageSize.GetRight(200) + len, document.PageSize.GetTop(45));
            //}
            //Add paging to footer
            {
                cb.BeginText();
                cb.SetFontAndSize(bf, 12);
                cb.SetTextMatrix(document.PageSize.GetRight(180), document.PageSize.GetBottom(30));
                cb.ShowText(text);
                cb.EndText();
                float len = bf.GetWidthPoint(text, 12);
                cb.AddTemplate(footerTemplate, document.PageSize.GetRight(180) + len, document.PageSize.GetBottom(30));
            }

            //Row 2
            iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(ImageUrl);
            img.ScaleAbsolute(30f, 30f);
            //Row 3 
            //PdfPCell pdfCell5 = new PdfPCell(new Phrase("Date:" + PrintTime.ToShortDateString(), baseFontSmall));
            PdfPCell pdfCell6 = new PdfPCell(img);
            pdfCell6.Colspan = 1;

            PdfPCell pdfCell8 = new PdfPCell(new Phrase("Class.....................,Section...................."));
            pdfCell8.Colspan = 1;
            PdfPCell pdfCell7 = new PdfPCell(new Phrase("Date:" + PrintTime.ToString("dd-MM-yyyy") + ",TIME:" + string.Format("{0:t}", DateTime.Now), baseFontSmall));

            //set the alignment of all three cells and set border to 0

            pdfCell2.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell3.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell4.HorizontalAlignment = Element.ALIGN_CENTER;



            // pdfCell5.HorizontalAlignment = Element.ALIGN_LEFT;
            pdfCell6.HorizontalAlignment = Element.ALIGN_LEFT;
            pdfCell7.HorizontalAlignment = Element.ALIGN_RIGHT;
            pdfCell8.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell8.Border = 0;
            pdfCell2.VerticalAlignment = Element.ALIGN_BOTTOM;


            // pdfCell5.VerticalAlignment = Element.ALIGN_MIDDLE;
            pdfCell6.VerticalAlignment = Element.ALIGN_MIDDLE;
            pdfCell7.VerticalAlignment = Element.ALIGN_MIDDLE;




            pdfCell2.Border = 0;
            pdfCell3.Border = 0;
            pdfCell4.Border = 0;


            // pdfCell5.Border = 0;
            pdfCell6.Border = 0;
            pdfCell7.Border = 0;

            //add all three cells into PdfTable

            pdfTab.AddCell(pdfCell2);
            pdfTab.AddCell(pdfCell3);
            pdfTab.AddCell(pdfCell4);


            //  pdfTab.AddCell(pdfCell5);
            pdfTab.AddCell(pdfCell6);
            pdfTab.AddCell(pdfCell8);
            pdfTab.AddCell(pdfCell7);

            pdfTab.TotalWidth = document.PageSize.Width - 80f;
            pdfTab.WidthPercentage = 70;
            //pdfTab.HorizontalAlignment = Element.ALIGN_CENTER;    

            //call WriteSelectedRows of PdfTable. This writes rows from PdfWriter in PdfTable
            //first param is start row. -1 indicates there is no end row and all the rows to be included to write
            //Third and fourth param is x and y position to start writing
            pdfTab.WriteSelectedRows(0, -1, 40, document.PageSize.Height - 30, writer.DirectContent);
            //set pdfContent value

            //Move the pointer and draw line to separate header section from rest of page
            cb.MoveTo(40, document.PageSize.Height - 106);
            cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 106);
            cb.Stroke();

            //Move the pointer and draw line to separate footer section from rest of page
            cb.MoveTo(40, document.PageSize.GetBottom(50));
            cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(50));
            cb.Stroke();
        }

        public override void OnCloseDocument(PdfWriter writer, Document document)
        {
            base.OnCloseDocument(writer, document);

            //headerTemplate.BeginText();
            //headerTemplate.SetFontAndSize(bf, 12);
            //headerTemplate.SetTextMatrix(0, 0);
            //headerTemplate.ShowText((writer.PageNumber - 1).ToString());
            //headerTemplate.EndText();

            footerTemplate.BeginText();
            footerTemplate.SetFontAndSize(bf, 12);
            footerTemplate.SetTextMatrix(0, 0);
            footerTemplate.ShowText((writer.PageNumber).ToString());
            footerTemplate.EndText();
        }
    }
    public static string _title = "";
    public void CreatePdf(string pdfPath, DataTable dt, string title,string total)
    {
        _title = title;
        Document doc = new Document(PageSize.A4.Rotate(), 0, 0, 107, 50);
        //doc.SetPageSize(PageSize.A4.Rotate());
        PdfWriter pdfWriter = PdfWriter.GetInstance(doc, new FileStream(pdfPath, FileMode.Create));
        pdfWriter.PageEvent = new ITextEvents();
        doc.Open();
        PdfPTable tableLayout = new PdfPTable(4);


        //tableLayout.AddCell(new PdfPCell(new Phrase(title, new Font(Font.NORMAL, 13, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_CENTER });
        //doc.Add(tableLayout);
        //float[] headers = { 5, 10, 11, 12, 12, 10, 10, 10, 10, 10 };
        PdfPTable tableLayout1 = new PdfPTable(dt.Columns.Count);

        tableLayout1.DefaultCell.Border = Rectangle.NO_BORDER;
        //tableLayout1.SetTotalWidth(headers);
        tableLayout1.WidthPercentage = 95;
        foreach (DataColumn dc in dt.Columns)
        {
            AddLabelCellToBody(tableLayout1, dc.ColumnName);
        }

        foreach (DataRow dr in dt.Rows)
        {
            foreach (DataColumn dc in dt.Columns)
            {
                if (Convert.ToString(dr[dc.ColumnName]).Trim()=="0")
                {
                    AddCellToBody(tableLayout1, "");
                }
                else
                {
                    AddCellToBody(tableLayout1, Convert.ToString(dr[dc.ColumnName]));
                }
                
            }
        }
        doc.Add(tableLayout1);
		if(total!="")
            {
                Font fnt = FontFactory.GetFont("Arial", 8);
                fnt.Size = 8;
                Paragraph p = new Paragraph("Total: " + total, fnt);
                
                p.Alignment = 1;
                   
                doc.Add(p);
                            
                
            }
        doc.Close();
    }

    private static void AddCellToBody(PdfPTable tableLayout, string cellText)
    {
        PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.HELVETICA, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = iTextSharp.text.BaseColor.WHITE };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }

    private static void AddCellToBody1(PdfPTable tableLayout, string cellText)
    {
        PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.HELVETICA, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new BaseColor(204, 204, 255) };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }

    private static void AddCellToBody2(PdfPTable tableLayout, string cellText)
    {
        PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.HELVETICA, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new BaseColor(234, 234, 250) };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }
    private static void AddLabelCellToBody(PdfPTable tableLayout, string cellText)
    {
        Font fontH1 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD, BaseColor.BLACK);
        //PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.WHITE))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(33, 49, 78) };
        PdfPCell cell = new PdfPCell(new Phrase(cellText, fontH1)) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(153, 204, 255) };
        //  cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }

    private static void AddLabelCellToBody1(PdfPTable tableLayout, string cellText)
    {
        // PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.WHITE))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(33,49,78) };
        Font fontH1 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Phrase(cellText, fontH1)) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(204, 229, 255) };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }
}