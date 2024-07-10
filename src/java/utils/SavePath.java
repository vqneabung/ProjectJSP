/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author VQN
 */
public class SavePath {

    public static void SavePath(HttpServletResponse response, String requestURI, String queryString) {

        String fullURL = queryString == null ? requestURI : requestURI + "?" + queryString;

        Cookie urlCookie = new Cookie("lastVisitedURL", fullURL);
        System.out.println(urlCookie.getValue());
        urlCookie.setMaxAge(60 * 60 * 24); // Cookie tồn tại trong 1 ngày
        response.addCookie(urlCookie);

    }

}
