/**
 * Created by DmytroDanilin on 14.12.2021.
 */

public with sharing class CurrencyConverter {
    private String userIso;

    private CurrencyConverter(){
        this.userIso = UserInfo.getDefaultCurrency();
    }

    public Decimal convert(String fromIso, String toIso, Decimal value){
        Decimal fromIsoConversionRate = getConversionRateFromIsoCode(fromIso);
        Decimal toIsoConversionRate = getConversionRateFromIsoCode(toIso);
        return (value/fromIsoConversionRate) * toIsoConversionRate;
    }

    public Decimal convert(String fromIso, Decimal value){
        Decimal fromIsoConversionRate = getConversionRateFromIsoCode(fromIso);
        Decimal toIsoConversionRate = getConversionRateFromIsoCode(this.userIso);
        return (value/fromIsoConversionRate) * toIsoConversionRate;
    }

    private Decimal getConversionRateFromIsoCode(String Iso){
        CurrencyType ct = [SELECT Id, IsCorporate, IsoCode, ConversionRate, DecimalPlaces
        FROM CurrencyType WHERE IsActive=TRUE AND IsoCode =:Iso];
        return ct.ConversionRate;
    }
    private void method(){}


}