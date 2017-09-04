package com.acception.util

import java.text.DecimalFormat
import java.text.Normalizer
import java.text.NumberFormat

class Util {
    static normalizar(String string) {
        return Normalizer.normalize(string, Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "").toUpperCase();
    }

    static parse(String amount) {
        Locale ptBr = new Locale("pt", "BR");
        final NumberFormat format = NumberFormat.getNumberInstance(ptBr);
        if (format instanceof DecimalFormat) {
            ((DecimalFormat) format).setParseBigDecimal(true);
        }
        return format.parse(amount.replaceAll("[^\\d.,]", "")).doubleValue();
    }

    static Date truncDate(Date d) {
        d.clearTime()
//        Calendar cal = new GregorianCalendar()
//        cal.setTime(d)
//        cal.set(Calendar.HOUR_OF_DAY, 0)
//        cal.set(Calendar.MINUTE, 0)
//        cal.set(Calendar.SECOND, 0)
//        cal.set(Calendar.MILLISECOND, 0)
//        cal.getTime()
    }

    static def phoneToRaw(String fullphone) {
        String phone = fullphone
        phone = phone.replaceAll('\\)', '')
        phone = phone.replaceAll('\\(', '')
        phone = phone.replaceAll('-', '')
        def _phone = phone.split(' ')
        String ddd = _phone[0]
        String number = _phone[1]

        return [ddd: ddd, number: number]
    }

    static public boolean validaCpf(String strCpf, formated = false) {
        def f = (!formated) || (strCpf ==~ /^([0-9]{3}\.){2}[0-9]{3}-[0-9]{2}$/)
        if (f) {
            if (!strCpf.substring(0, 1).equals("")) {
                try {
                    boolean validado = true;
                    int d1, d2;
                    int dg1, dg2, resto;
                    int dgCPF;
                    String nDigResult;
                    strCpf = strCpf.replace('.', ' ');
                    strCpf = strCpf.replace('-', ' ');
                    strCpf = strCpf.replaceAll(" ", "");
                    d1 = d2 = 0;
                    dg1 = dg2 = resto = 0;
                    for (int nCount = 1; nCount < strCpf.length() - 1; nCount++) {
                        dgCPF = Integer.valueOf(strCpf.substring(nCount - 1, nCount)).intValue();
                        d1 = d1 + (11 - nCount) * dgCPF;
                        d2 = d2 + (12 - nCount) * dgCPF;
                    };
                    resto = (d1 % 11);
                    if (resto < 2) dg1 = 0;
                    else dg1 = 11 - resto;
                    d2 += 2 * dg1;
                    resto = (d2 % 11);
                    if (resto < 2) dg2 = 0;
                    else dg2 = 11 - resto;
                    String nDigVerific = strCpf.substring(strCpf.length() - 2, strCpf.length());
                    nDigResult = String.valueOf(dg1) + String.valueOf(dg2);
                    return nDigVerific.equals(nDigResult);
                } catch (Exception e) {
                    return false;
                }
            } else return false;
        } else false
    }

    static public boolean validaCnpj(String str_cnpj, formated = false) {
        def f = (!formated) || (str_cnpj ==~ /^[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}-[0-9]{2}$/) || (str_cnpj ==~ /^[0-9]{14}$/)
        if (f) {
            if (!str_cnpj.substring(0, 1).equals("")) {
                try {
                    str_cnpj = str_cnpj.replace('.', ' ');
                    str_cnpj = str_cnpj.replace('/', ' ');
                    str_cnpj = str_cnpj.replace('-', ' ');
                    str_cnpj = str_cnpj.replaceAll(" ", "");
                    int soma = 0, aux, dig;
                    String cnpj_calc = str_cnpj.substring(0, 12);

                    if (str_cnpj.length() != 14) return false;
                    char[] chr_cnpj = str_cnpj.toCharArray();
                    for (int i = 0; i < 4; i++)
                        if (chr_cnpj[i] - 48 >= 0 && chr_cnpj[i] - 48 <= 9) soma += (chr_cnpj[i] - 48) * (6 - (i + 1));
                    for (int i = 0; i < 8; i++)
                        if (chr_cnpj[i + 4] - 48 >= 0 && chr_cnpj[i + 4] - 48 <= 9) soma += (chr_cnpj[i + 4] - 48) * (10 - (i + 1));
                    dig = 11 - (soma % 11);
                    cnpj_calc += (dig == 10 || dig == 11) ? "0" : Integer.toString(dig);
                    soma = 0;
                    for (int i = 0; i < 5; i++)
                        if (chr_cnpj[i] - 48 >= 0 && chr_cnpj[i] - 48 <= 9) soma += (chr_cnpj[i] - 48) * (7 - (i + 1));
                    for (int i = 0; i < 8; i++)
                        if (chr_cnpj[i + 5] - 48 >= 0 && chr_cnpj[i + 5] - 48 <= 9) soma += (chr_cnpj[i + 5] - 48) * (10 - (i + 1));
                    dig = 11 - (soma % 11);
                    cnpj_calc += (dig == 10 || dig == 11) ? "0" : Integer.toString(dig);
                    return str_cnpj.equals(cnpj_calc);
                } catch (Exception e) {
                    return false;
                }
            } else return false;
        } else false

    }

    static String limitTo(String s, int l) {
        if (s && s.size() > l)
            s.substring(0, l)
        else s
    }

    static String cepToRaw(cep) {
        def raw = cep
        if (raw) {
            raw = raw.replace('.', '')
            raw = raw.replace('-', '')
        }
        raw
    }

    static String cnpjToRaw(String cnpj) {
        def raw = cnpj
        if (raw) {
            raw = raw.replace('.', '')
            raw = raw.replace('-', '')
            raw = raw.replace('/', '')
        }
        Util.leftPad(raw, 14, (char) '0')
    }

    static String rawToCnpj(raw) {
        if (!raw) return null
        raw = raw.replace('.', '')
        raw = raw.replace('-', '')
        raw = raw.replace('/', '')
        def a, b, c, d, e
        if (raw.size() >= 2)
            a = raw.substring(0, 2)
        else a = raw
        if (raw.size() >= 5)
            b = raw.substring(2, 5)
        else if (raw.size() > 2) b = raw.substring(2, raw.size())
        if (raw.size() >= 8)
            c = raw.substring(5, 8)
        else if (raw.size() > 5) c = raw.substring(5, raw.size())
        if (raw.size() >= 12)
            d = raw.substring(8, 12)
        else if (raw.size() > 8) d = raw.substring(8, raw.size())
        if (raw.size() >= 14)
            e = raw.substring(12, 14)
        else if (raw.size() > 12) d = raw.substring(12, raw.size())
        def r = ""
        if (a) r = a
        if (b) r = r + '.' + b
        if (c) r = r + '.' + c
        if (d) r = r + '/' + d
        if (e) r = r + '-' + e
        r
    }

    static String cpfToRaw(String cpf) {
        String raw = cpf
        if (raw) {
            raw = raw.replace('.', '')
            raw = raw.replace('-', '')
            raw = Util.leftPad(raw, 11, (char) '0')
            return raw.replaceAll("[^\\d]", "")
        } else {
            raw
        }
    }

    static String rawToCpf(raw) {
        if (!raw) return null
        raw = raw.replace('.', '')
        raw = raw.replace('-', '')
        def a, b, c, d
        if (raw.size() >= 3)
            a = raw.substring(0, 3)
        else a = raw
        if (raw.size() >= 6)
            b = raw.substring(3, 6)
        else if (raw.size() > 3) b = raw.substring(3, raw.size())
        if (raw.size() >= 9)
            c = raw.substring(6, 9)
        else if (raw.size() > 6) c = raw.substring(6, raw.size())
        if (raw.size() >= 11)
            d = raw.substring(9, 11)
        else if (raw.size() > 9) d = raw.substring(9, raw.size())
        def r = ""
        if (a) r = a
        if (b) r = r + '.' + b
        if (c) r = r + '.' + c
        if (d) r = r + '-' + d
        r
    }

    static String leftPad(String s, int len, char c = ' ') {
        def t = s
        if (!t) t = ''
        while (t.size() < len) t = c.toString() + t
        t
    }

    static moneyMask(value, String moeda = 'R$') {
        def df = new DecimalFormat('###,##0.00')

        if (value == null) {
            return null;
        }

        return "${moeda} ${df.format(value)} "
    }

    // When we make a AJAX request to create a given object, we have to send some values on the response, to update for
    // example a table. This function updates the response with the values to send back.
    static updateResponseWithValuesToSendBack(response, createdObject, attributes) {
        if (attributes) {
            def attributesToSendBack = attributes.split(',')

            for (String attr in attributesToSendBack) {
                def value = attr.split(/\./).inject(createdObject) { obj, prop -> obj?."$prop" }

                if (value instanceof Date) {
                    value = value.format('dd/MM/yyyy')
                }

                response[attr] = value?.toString()
            }
        }
    }

    static Map trimMap(Map map) {
        Map finalMap = map?.clone() ?: new HashMap<String, String>()
        map.each { key, value ->
            if (value.toString().isEmpty()) finalMap.remove(key)
        }

        finalMap
    }
}
