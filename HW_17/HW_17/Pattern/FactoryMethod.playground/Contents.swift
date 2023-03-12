// MARK: - Factory Method

// Фабричный метод — это порождающий паттерн проектирования, который определяет общий интерфейс для создания объектов в суперклассе, позволяя подклассам изменять тип создаваемых объектов.

// Пример: создание персонажей-врагов(афинян) в игре (гипаспист, пельтаст, фалангит)

protocol Enemy {
    func attack()
}

class Hypaspist: Enemy {
    func attack() {
        print("Hypaspist attack")
    }
}

class Peltast: Enemy {
    func attack() {
        print("Peltast attack")
    }
}

class Phalangitis: Enemy {
    func attack() {
        print("Phalangitis attack")
    }
}

protocol EnemyFactory {
    func produce() -> Enemy
}

class HypaspistFactory: EnemyFactory {
    func produce() -> Enemy {
        print("Hypaspist is created")
        return Hypaspist()
    }
}

class PeltastFactory: EnemyFactory {
    func produce() -> Enemy {
        print("Peltast is created")
        return Peltast()
    }
}

class PhalangitisFactory: EnemyFactory {
    func produce() -> Enemy {
        print("Phalangitis is created")
        return Phalangitis()
    }
}

let hypaspistFactory = HypaspistFactory()
let hypaspistVukol = hypaspistFactory.produce()

let peltastFactory = PeltastFactory()
let peltastIsidore = peltastFactory.produce()

let phalangitisFactory = PhalangitisFactory()
let phalangitisPatroclus = phalangitisFactory.produce()
