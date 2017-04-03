package com.lotte.controller;

import java.io.IOException;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
//Controller�쓽 �뿭�븷�� �뼱�뒓 酉곗뿉 �굹���궪吏� �꽑�젙�븯�뒗 寃껉낵 �빐�떦 �옉�뾽�뿉 �뵲瑜� �뼱�뒓 �꽌鍮꾩뒪瑜� �샇異쒗빐�빞 �븯�뒗吏� �꽕�젙�빐以��떎.//
public class LoginController {
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginview(Locale locale) throws IOException {
		ModelAndView view = new ModelAndView();
		
		System.out.println("");
		
		view.setViewName("/loginview");
		
		return view;
	}
}
