/**
 * Created by DmytroDanilin on 15.12.2021.
 */

public with sharing class Client {
    public Decimal convert(String fromIso, String toIso, Decimal value){
        DependencyInjection__mdt dependencyInjection = this.getDependencyInjectionMetaData();
        CurrencyConverter currencyConverter = (CurrencyConverter) DependencyInjector.inject(Type.forName(dependencyInjection.InterfaceName__c));
        return currencyConverter.convert(fromIso,toIso, value);
    }

    private DependencyInjection__mdt getDependencyInjectionMetaData(){
        return [SELECT Id, DeveloperName, InterfaceName__c, MappedClass__c
        FROM DependencyInjection__mdt];
    }

}