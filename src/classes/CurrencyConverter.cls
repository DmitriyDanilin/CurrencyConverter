/**
 * Created by DmytroDanilin on 14.12.2021.
 */

public with sharing class CurrencyConverter {
    private String userIso;
    private CurrencyTypeDomain currencyTypeDomain;

    private CurrencyConverter(){
        this.userIso = UserInfo.getDefaultCurrency();
        this.currencyTypeDomain = new CurrencyTypeDomain();
    }

    public Decimal convert(String fromIso, String toIso, Decimal value){
        Decimal fromIsoConversionRate = this.currencyTypeDomain.getConversionRateFromIsoCode(fromIso);
        Decimal toIsoConversionRate = this.currencyTypeDomain.getConversionRateFromIsoCode(toIso);
        return (value/fromIsoConversionRate) * toIsoConversionRate;
    }

    public Decimal convert(String fromIso, Decimal value){
        Decimal fromIsoConversionRate = this.currencyTypeDomain.getConversionRateFromIsoCode(fromIso);
        Decimal toIsoConversionRate = this.currencyTypeDomain.getConversionRateFromIsoCode(this.userIso);
        return (value/fromIsoConversionRate) * toIsoConversionRate;
    }


    private class CurrencyTypeDomain{
        public Map<String,CurrencyType> isoCodeToCurrencyType = new Map<String,CurrencyType>();

        private CurrencyTypeDomain(){
            List<CurrencyType> currencyTypes= getCurrencyTypes();
            for (CurrencyType ct : currencyTypes){
                this.isoCodeToCurrencyType.put(ct.IsoCode,  ct);
            }
        }

        public Decimal getConversionRateFromIsoCode(String Iso){
            return this.isoCodeToCurrencyType.get(Iso).ConversionRate;
        }

        private List<CurrencyType> getCurrencyTypes(){
            return [SELECT Id, IsCorporate, IsoCode, ConversionRate, DecimalPlaces
            FROM CurrencyType WHERE IsActive=TRUE ];
        }

    }
}