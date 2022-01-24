package kr.nshare.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * packageName              : kr.nshare.common.util           <p>
 * <p>
 * fileName                 : formBasedFileUtil
 * <p>
 * author                   : USER
 * <p>
 * date                     : 2021-12-09
 * <p>
 * description :
 * <p>
 * ===========================================================
 * <p>
 * DATE              AUTHOR                        NOTE
 * <p>
 * -----------------------------------------------------------
 * <p>
 * 2021-12-09            USER                      최초 생성
 */
public class formBasedFileUtil {
        /**
         * 금년, 금월 문자열 취득.
         * ex)20090101
         * @return
         */
        public static String getThisMonthString ()
        {
            SimpleDateFormat format = new SimpleDateFormat("yyyyMM", Locale.getDefault());
            return format.format(new Date());
        }

        /**
         * 금년, 금월, 금일, 시, 분, 초 취득.
         * ex)20090101155517
         * @return
         */
        public static String getNowString ()
        {
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault());
            return format.format(new Date());
        }
    }
