/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.StringJoiner;
import java.util.StringTokenizer;

/**
 *
 * @author VQN
 */
public class Utils {

    public static String arrayToString(String[] arr) {

        String str = "null";
        if (arr != null) {
            StringJoiner joiner = new StringJoiner(",");
            for (int i = 0; i < arr.length; i++) {
                joiner.add(arr[i]);
            }
            str = joiner.toString();
        }
        return str;
    }

    public static String[] stringToArray(String str) {

        String[] arr = {"null"};
        if (str != null) {
            arr = str.split(",");
            if (arr[arr.length - 1].isEmpty()) {
                arr[arr.length - 1] = null;
            }
        }
        return arr;

    }

}
