using System;
using System.Web;

public partial class ConvertImageToBase64 : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

        if (!Page.IsPostBack)
        {
            Response.Clear();
            int maxHeight = 200; // configurar según requerimientos;
            int maxWidth = 300; // se puede configurar desde un archivo en caso de pre-compilar;
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

//            byte[] pBuffer = ConvertImageToBase64.CreateThumbnail(imageName, maxHeight, maxWidth, extension);
//		    string base64ImageString = Convert.ToBase64String(pBuffer);

		    string base64ImageString = Convert.ToBase64String(ConvertImageToBase64.CreateThumbnail(imageName, maxHeight, maxWidth, extension));
		    base64ImageString = "data:image/"+extension+";base64," + base64ImageString;
            byte[] pBuffer = System.Text.Encoding.UTF8.GetBytes(base64ImageString);

            //set response content type: image/jpeg, image/gif, image/png, etc...
            //Response.ContentType = "image/" + extension;
            //write the image to the output stream
            //Response.OutputStream.Write(pBuffer, 0, pBuffer.Length);


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
