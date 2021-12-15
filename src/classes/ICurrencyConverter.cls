/**
 * Created by DmytroDanilin on 15.12.2021.
 */

public interface ICurrencyConverter {
    Decimal convert(String fromIso, String toIso, Decimal value);
    Decimal convert(String fromIso, Decimal value);
}