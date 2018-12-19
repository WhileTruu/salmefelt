module Common.Translations exposing (getTranslationsForLanguage)

import Common.Types.Language as Language exposing (Language)
import Common.Translations.EN as English
import Common.Translations.ET as Estonian
import Common.Types.Translations exposing (Translations)


getTranslationsForLanguage : Language -> Translations
getTranslationsForLanguage language =
    case language of
        Language.ET ->
            Estonian.translations

        Language.EN ->
            English.translations
