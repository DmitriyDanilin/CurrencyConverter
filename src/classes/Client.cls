/**
 * Created by DmytroDanilin on 15.12.2021.
 */

public with sharing class Client {
    public Decimal convert(String fromIso, String toIso, Decimal value){
        CurrencyConverter currencyConverter = (CurrencyConverter) DependencyInjector.inject(ICurrencyConverter.class);
        return currencyConverter.convert(fromIso,toIso, value);
    }
}