
import Foundation

enum EmotionWheel {

    struct Secondary: Identifiable, Hashable {
        let title: String
        let tertiaries: [String]
        var id: String { title }
    }

    static func secondaries(for primary: PrimaryEmotion) -> [Secondary] {
        switch primary {

        case .fear:
            return [
                .init(title: "Humillado", tertiaries: ["Ridiculizado", "Irrespetado"]),
                .init(title: "Rechazado", tertiaries: ["Alienado", "Marginado"]),
                .init(title: "Sumiso", tertiaries: ["Insignificante", "Inútil"]),
                .init(title: "Inseguro", tertiaries: ["Inferior", "Insuficiente"]),
                .init(title: "Ansioso", tertiaries: ["Preocupado", "Agobiado"]),
                .init(title: "Asustado", tertiaries: ["Espantado", "Aterrado"])
            ]

        case .anger:
            return [
                .init(title: "Herido", tertiaries: ["Celoso", "Resentido"]),
                .init(title: "Amenazado", tertiaries: ["Atacado", "Hostil"]),
                .init(title: "Lleno de odio", tertiaries: ["Ultrajado", "Violado"]),
                .init(title: "Loco", tertiaries: ["Furioso", "Rabioso"]),
                .init(title: "Agresivo", tertiaries: ["Provocador", "Hostil"]),
                .init(title: "Frustrado", tertiaries: ["Enfurecido", "Irritado"]),
                .init(title: "Distante", tertiaries: ["Introvertido", "Desconfiado"]),
                .init(title: "Crítico", tertiaries: ["Escéptico", "Sarcástico"])
            ]

        case .disgust:
            return [
                .init(title: "Disconforme", tertiaries: ["Moralista", "Reacio"]),
                .init(title: "Decepcionado", tertiaries: ["Repugnante", "Revoltoso"]),
                .init(title: "Horrible", tertiaries: ["Asco", "Odioso"]),
                .init(title: "Abstinencia", tertiaries: ["Aversión", "Vacilante"])
            ]

        case .sadness:
            return [
                .init(title: "Culpable", tertiaries: ["Avergonzado", "Arrepentido"]),
                .init(title: "Abandonado", tertiaries: ["Ignorado", "Victimizado"]),
                .init(title: "Desesperado", tertiaries: ["Desvalido", "Vulnerable"]),
                .init(title: "Deprimido", tertiaries: ["Melancólico", "Vacío"]),
                .init(title: "Solo", tertiaries: ["Desamparado", "Aislado"]),
                .init(title: "Aburrido", tertiaries: ["Apático", "Indiferente"])
            ]

        case .joy:
            return [
                .init(title: "Optimista", tertiaries: ["Esperanzado", "Inspirado"]),
                .init(title: "Íntimo", tertiaries: ["Cariñoso", "Sensible"]),
                .init(title: "Pacífico", tertiaries: ["Satisfecho", "Liberado"]),
                .init(title: "Poderoso", tertiaries: ["Valiente", "Seguro"]),
                .init(title: "Aceptado", tertiaries: ["Respetado", "Importante"]),
                .init(title: "Orgulloso", tertiaries: ["Seguro", "Satisfecho"]),
                .init(title: "Interesado", tertiaries: ["Curioso", "Abierto"]),
                .init(title: "Alegre", tertiaries: ["Eufórico", "Entusiasta"])
            ]

        case .surprise:
            return [
                .init(title: "Sorprendido", tertiaries: ["Conmocionado", "Abatido"]),
                .init(title: "Confundido", tertiaries: ["Desilusionado", "Perplejo"]),
                .init(title: "Asombrado", tertiaries: ["Estupefacto", "Impresionado"]),
                .init(title: "Entusiasmado", tertiaries: ["Entusiasta", "Enérgico", "Bromista"])
            ]
        }
    }
}
