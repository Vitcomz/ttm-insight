using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class _Default : System.Web.UI.Page
{
 protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Response.Clear();
            int maxHeight = 200; // you can get from your config file;
            int maxWidth = 300; // you can get from your config file;
            if (Request["width"] != null)
            {
                maxWidth = Int32.Parse(Request["width"].ToString());
            }
            if (Request["height"] != null)
            {
                maxHeight = Int32.Parse(Request["height"].ToString());
            }


            string imageName = Request.QueryString["image"];
            string extension = System.IO.Path.GetExtension(Server.MapPath(imageName));

            byte[] pBuffer = _Default.CreateThumbnail(imageName, maxHeight, maxWidth, extension);
            //set response content type: image/jpeg, image/gif, image/png, etc...
            Response.ContentType = "image/" + extension;
            //write the image to the output stream
            Response.OutputStream.Write(pBuffer, 0, pBuffer.Length);

            Response.End();
        }
    }

 /// <summary>
 /// Create thumbnail of the image
 /// </summary>
 /// <param name="path"></param>
 /// <param name="maxHeight"></param>
 /// <param name="maxWidth"></param>
 /// <param name="extension"></param>
 /// <returns></returns>
 public static byte[] CreateThumbnail(string path, int maxHeight, int maxWidth, string extension)
 {
     path = HttpContext.Current.Server.MapPath(path);
     System.Drawing.Image img = System.Drawing.Image.FromFile(path);
     extension = extension.ToLower();

     byte[] buffer = null;
     try
     {
         int width = img.Size.Width;
         int height = img.Size.Height;

         bool doWidthResize = (maxWidth > 0 && width > maxWidth && width > maxHeight);
         bool doHeightResize = (maxHeight > 0 && height > maxHeight && height > maxWidth);

         //only resize if the image is bigger than the max
         if (doWidthResize || doHeightResize)
         {
             int iStart;
             Decimal divider;
             if (doWidthResize)
             {
                 iStart = width;
                 divider = Math.Abs((Decimal)iStart / (Decimal)maxWidth);
                 width = maxWidth;
                 height = (int)Math.Round((Decimal)(height / divider));
             }
             else
             {
                 iStart = height;
                 divider = Math.Abs((Decimal)iStart / (Decimal)maxHeight);
                 height = maxHeight;
                 width = (int)Math.Round((Decimal)(width / divider));
             }
          }
            System.Drawing.Image newImg = img.GetThumbnailImage(width, height, null, new System.IntPtr());
             try
             {
                 using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
                 {
                     if (extension.IndexOf("jpg") > -1)
                     {
                         newImg.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                     }
                     else if (extension.IndexOf("png") > -1)
                     {
                         newImg.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                     }
                     else if (extension.IndexOf("gif") > -1)
                     {
                         newImg.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
                     }
                     else // if (extension.IndexOf("bmp") > -1)
                     {
                         newImg.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
                     }
                     buffer = ms.ToArray();
                 }
             }
             finally
             {
                 newImg.Dispose();
             }
     }
     catch
     {
         System.Drawing.Image imNoimage = System.Drawing.Image.FromFile("/images/noimage.gif");
         try
         {
             using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
             {
                 imNoimage.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
                 buffer = ms.ToArray();
             }
         }
         finally
         {
             imNoimage.Dispose();
         }
     }
     finally
     {
         img.Dispose();
     }
     return buffer;
 } 

}
