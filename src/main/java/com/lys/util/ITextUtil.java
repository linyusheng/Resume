package com.lys.util;

import java.io.FileOutputStream;
import java.io.OutputStream;

import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.pdf.BaseFont;

/**
 * iText 工具类
 * @author between
 *
 */
public class ITextUtil {
	
//	/**
//	 * 将HTML转换为Pdf
//	 * @param htmlUrl
//	 * @param pdfUrl
//	 */
//	public static void HtmlToPdf(String htmlUrl,String pdfUrl) {
//		try {
//			String inputFile = "E:/preview.html";
//			String url = new File( inputFile ).toURI().toURL().toString();
//			String outputFile = "C:/Users/between/Desktop/resume.pdf";     
//			OutputStream os = new FileOutputStream( outputFile );     
//			ITextRenderer renderer = new ITextRenderer();
//			ITextFontResolver fontResolver = renderer.getFontResolver();  
//			fontResolver.addFont("C:/Windows/fonts/simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
//			renderer.setDocument( url );
//			renderer.layout();     
//			renderer.createPDF( os );     
//			os.close();
//		} catch (Exception e) {
//			System.out.println(e);
//		}
//	}
	/**
	 * 将HTML转换为Pdf
	 * @param htmlUrl
	 * @param pdfUrl
	 */
	public static void HtmlToPdf(String htmlUrl,String savePath) {
		try {
			OutputStream os = new FileOutputStream( savePath );     
			ITextRenderer renderer = new ITextRenderer();
			ITextFontResolver fontResolver = renderer.getFontResolver();  
			fontResolver.addFont("C:/Windows/fonts/simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
			renderer.setDocument( htmlUrl );     
			renderer.layout();     
			renderer.createPDF( os );     
			os.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
	public static void main(String[] args) {
		
	}
	
	

}
