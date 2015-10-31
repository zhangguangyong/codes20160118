package com.codes.common.util;

public abstract class StringUtils {
	
	static enum WrapType{
		FULL, START, END
	}
	
	public static boolean hasLength(String str){
		return ObjectUtils.isNotNull(str) && str.length() > 0;
	}

	public static boolean hasText(String str){
		return hasLength(str) && str.trim().length() > 0;
	}
	
	public static String join(String symbol, String ... vals){
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < vals.length-1; i++) {
			sb.append(vals[i]).append(symbol);
		}
		sb.append(vals[vals.length-1]);
		return sb.toString();
	}
	
	public static String[] wrapFull(String symbol, Object ... vals){
		return wrap(symbol, WrapType.FULL, vals);
	}

	public static String[] wrapStart(String symbol, Object ... vals){
		return wrap(symbol, WrapType.START, vals);
	}

	public static String[] wrapEnd(String symbol, Object ... vals){
		return wrap(symbol, WrapType.END, vals);
	}
	
	private static String[] wrap(String symbol, WrapType type, Object ... vals){
		String[] ret = new String[vals.length];
		for (int i = 0; i < vals.length; i++) {
			switch (type) {
				case FULL: ret[i] = symbol + vals[i] + symbol; break; 
				case START: ret[i] = symbol + vals[i]; break; 
				case END: ret[i] = vals[i] + symbol; break; 
			}
		}
		return ret;
	}
	
	public static void main(String[] args) {
		System.out.println( join(",", wrapFull("'", "a", "b", "c")) );
	}
	
}
