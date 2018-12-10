package com.jojowonet.modules.fmss.utils;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;

import org.apache.log4j.Logger;

/**
 * 加密、解密工具
 * xsg
 */
public class Encrypt {
	/**
	 *  默认密码
	 */
	private static final String defaultPassword = "ah.meeting@wondertek.com.cn";
	
	/**
	 *  默认的盐
	 */
	private static byte[] salt = new byte[] { 24, -121, -109, 109, 53, 58, 106, -96 };
	
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Encrypt.class);
	
	/**
	 * <pre>
	 * PBEWithMD5AndDES      
	 * PBEWithMD5AndTripleDES      
	 * PBEWithSHA1AndDESede     
	 * PBEWithSHA1AndRC2_40
	 * </pre>
	 */
	private static final String ALGORITHM = "PBEWITHMD5andDES";

	/**
	 *  将byte数组转换为表16进制值的字符串
	 * @param arrB
	 * @return
	 */
	public static String byteArr2HexStr(final byte[] arrB) {
		final int iLen = arrB.length;
		// 每个byte用两个字符才能表示
		final StringBuffer sb = new StringBuffer(iLen * 2);
		for (int i = 0; i < iLen; i++) {
			int intTmp = arrB[i];
			// 把负数转换为正数
			while (intTmp < 0) {
				intTmp = intTmp + 256;
			}
			// 小于0F的数 在前面补0
			if (intTmp < 16) {
				sb.append("0");
			}
			sb.append(Integer.toString(intTmp, 16));
		}
		return sb.toString();
	}

	/**
	 * 将表16进制值的字符串转换为byte数组
	 * @param strIn
	 * @return
	 */
	public static byte[] hexStr2ByteArr(final String strIn) {
		final byte[] arrB = strIn.getBytes();
		final int iLen = arrB.length;

		// 两个字符表示�?��字节，所以字节数组长度是字符串长度除�?
		final byte[] arrOut = new byte[iLen / 2];
		for (int i = 0; i < iLen; i = i + 2) {
			final String strTmp = new String(arrB, i, 2);
			arrOut[i / 2] = (byte) Integer.parseInt(strTmp, 16);
		}
		return arrOut;
	}

	/** */
	/**
	 * 转换密钥<br>
	 * 
	 * @param password
	 * @return
	 * @throws Exception
	 */
	private static Key toKey(String password) throws Exception {
		password = password == null ? defaultPassword : password;

		final PBEKeySpec keySpec = new PBEKeySpec(password.toCharArray());
		final SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);
		final SecretKey secretKey = keyFactory.generateSecret(keySpec);
		return secretKey;
	}

	/** */
	/**
	 * 加密, 加密的数据和返回后的数据都是byte数组
	 * 
	 * @param data
	 *            数据
	 * @param password
	 *            密码
	 * @return
	 * @throws Exception
	 */
	public static byte[] encrypt(final byte[] data, final String password) {
		if (data == null) {
			return null;
		}
		try {
			final Key key = toKey(password);
			final PBEParameterSpec paramSpec = new PBEParameterSpec(salt, 100);
			final Cipher cipher = Cipher.getInstance(ALGORITHM);
			cipher.init(Cipher.ENCRYPT_MODE, key, paramSpec);
			return cipher.doFinal(data);
		} catch (final Exception e) {
			logger.info("encrypt password:" + password + "error");
		}
		return null;

	}

	/**
	 * 加密，要加密的数据及返回的数据都是String
	 * 
	 * @param data
	 * @param password
	 * @return
	 */
	public static String encrypt(final String data, final String password) {
		if (data == null) {
			return "";
		}
		final byte[] tmp = encrypt(data.getBytes(), password);
		return byteArr2HexStr(tmp);
	}

	/** */
	/**
	 * 解密,要解密的数据和返回后的数据都是byte数组
	 * 
	 * @param data
	 *            数据
	 * @param password
	 *            密码
	 * @return
	 * @throws Exception
	 */
	public static byte[] decrypt(final byte[] data, final String password) {
		if (data == null) {
			return null;
		}
		try {
			final Key key = toKey(password);

			final PBEParameterSpec paramSpec = new PBEParameterSpec(salt, 100);
			final Cipher cipher = Cipher.getInstance(ALGORITHM);
			cipher.init(Cipher.DECRYPT_MODE, key, paramSpec);
			return cipher.doFinal(data);
		} catch (final Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 解密，要解密的数据及返回的数据都是String
	 * 
	 * @param data
	 * @param password
	 * @return
	 */
	public static String decrypt(final String data, final String password) {
		if (data == null) {
			return "";
		}
		try{
			final byte[] tmp = decrypt(hexStr2ByteArr(data), password);
			return new String(tmp);
		} catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 测试代码
	 * 
	 * @param args
	 */
	public static void main(final String[] args) {
		long l = System.currentTimeMillis();
		final String str2 = Encrypt.encrypt(String.valueOf(l), null);
	}
}