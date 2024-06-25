using System;
using System.Drawing.Imaging;
using System.IO;

/// <summary>
/// Summary description for MasterImageUpload
/// </summary>
public class MasterImageUpload
{
    public MasterImageUpload()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void CreateImage(byte[] b, string imagename, string extens, string pathforsaveimage, int Mode = 0)
    {
        MemoryStream ms = new System.IO.MemoryStream(b);
        System.Drawing.Image img = System.Drawing.Image.FromStream(ms);
        pathforsaveimage = Path.ChangeExtension(pathforsaveimage, extens).ToString();
        if (System.IO.File.Exists(pathforsaveimage))
        {
            System.IO.File.Delete(pathforsaveimage);
        }
        double radio = 1; double newWidth1 = 0; double newHeight1 = 0;

        newWidth1 = (int)(img.Width);
        newHeight1 = (int)(img.Height);
        radio = newWidth1 / newHeight1;
        int iwidth = (int)(img.Width);
        int iheight = (int)(img.Height);
        if (Mode == 0)
        {
            if ((int)(img.Width) > 170)
            {
                iwidth = 170;
            }
            if ((int)(img.Height) > 170)
            {
                iheight = 170;
            }
        }
        else
        {
            if ((int)(img.Width) > 500)
            {
                iwidth = 500;
            }
            if ((int)(img.Height) > 500)
            {
                iheight = 500;
            }
        }
        //======================small
        //  iwidth = Convert.ToInt32(abc1); iheight = Convert.ToInt32(abc2);
        if (radio < 1)
        {
            if ((iwidth > 170) || (iheight > 170))
            {
                iwidth = Convert.ToInt32(iwidth * radio);
                iheight = Convert.ToInt32(iheight * radio);
            }
        }
        else if (radio > 1)
        {
            if ((iwidth > 170) || (iheight > 170))
            {
                iwidth = Convert.ToInt32(iwidth / radio);
                iheight = Convert.ToInt32(iheight / radio);
            }
        }
        System.Drawing.Image objOptImagesmall = new System.Drawing.Bitmap(iwidth, iheight, System.Drawing.Imaging.PixelFormat.Format16bppRgb555);
        using (System.Drawing.Image.FromStream(ms))
        {
            using (System.Drawing.Graphics oGraphic = System.Drawing.Graphics.FromImage(objOptImagesmall))
            {
                var _1 = oGraphic;
                System.Drawing.Rectangle oRectangle = new System.Drawing.Rectangle(0, 0, iwidth, iheight);
                _1.DrawImage(System.Drawing.Image.FromStream(ms), oRectangle);
            }
            EncoderParameters encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(Encoder.Compression, 100);// 100% Percent Compression
            objOptImagesmall.Save(pathforsaveimage, ImageCodecInfo.GetImageEncoders()[1], encoderParameters);// jpg format
            img.Dispose();
        }
        objOptImagesmall.Dispose();
    }
}