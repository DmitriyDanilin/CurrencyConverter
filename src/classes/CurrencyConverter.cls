
public with sharing class CurrencyConverter implements ICurrencyConverter{

    public static Map<String,CurrencyType> currencyTypeByIsoCode { private get{
        if (currencyTypeByIsoCode == null) {
            currencyTypeByIsoCode = getCurrencyTypeByIsoCode();
        }
        return currencyTypeByIsoCode;
    } private set;}

    public Decimal convert(String fromIso, String toIso, Decimal value){
        Decimal fromIsoConversionRate = getConversionRateByIsoCode(fromIso);
        Decimal toIsoConversionRate = getConversionRateByIsoCode(toIso);
        return (value/fromIsoConversionRate) * toIsoConversionRate;
    }

    public Decimal convert(String fromIso, Decimal value){
        Decimal fromIsoConversionRate = getConversionRateByIsoCode(fromIso);
        Decimal toIsoConversionRate = getConversionRateByIsoCode(UserInfo.getDefaultCurrency());
        return (value/fromIsoConversionRate) * toIsoConversionRate;
    }

    public Decimal getConversionRateByIsoCode(String Iso){
        return currencyTypeByIsoCode.get(Iso).ConversionRate;
    }

    private static Map<String,CurrencyType> getCurrencyTypeByIsoCode(){
        List<CurrencyType> currencyTypes = getCurrencyTypes();
        Map<String,CurrencyType> currTypeByIsoCode = new Map<String, CurrencyType>();
        for (CurrencyType ct : currencyTypes){
            currTypeByIsoCode.put(ct.IsoCode,  ct);
        }
        return currTypeByIsoCode;
    }
    private static List<CurrencyType> getCurrencyTypes(){
        return [SELECT Id, IsCorporate, IsoCode, ConversionRate, DecimalPlaces
        FROM CurrencyType WHERE IsActive=TRUE ];
    }
}