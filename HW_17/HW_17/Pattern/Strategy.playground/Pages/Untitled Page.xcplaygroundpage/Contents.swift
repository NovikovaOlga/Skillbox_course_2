// MARK: - Strategy

//Стратегия — это поведенческий паттерн проектирования, который определяет семейство схожих алгоритмов и помещает каждый из них в собственный класс, после чего алгоритмы можно взаимозаменять прямо во время исполнения программы.

// Пример: генерация в игре жителей деревни с определенными навыками

protocol CommunicationSkill { // поддержка разговора
    func talk()
}

class Silent: CommunicationSkill { // молчаливый
    func talk() {
        print("персонаж не поддерживает диалог")
    }
}

class Talkative: CommunicationSkill { // болтливый
    func talk() {
        print("персонаж поддерживает диалог")
    }
}

protocol FriendlinessSkill { // доброжелательность
    func friendliness()
}

class Friend: FriendlinessSkill { // дружественный
    func friendliness() {
        print("персонаж дружелюбен")
    }
}

class Neutral: FriendlinessSkill { // нейтральный
    func friendliness() {
        print("персонаж нейтрален")
    }
}

class Enemy: FriendlinessSkill { // враждебный
    func friendliness() {
        print("персонаж враждебен")
    }
}

protocol RewardSkill { // награды за исполнение заданий
    func reward()
}

class RewardYes: RewardSkill {
    func reward() {
        print("награды за выполнение заданий")
    }
}

class RewardNo: RewardSkill {
    func reward() {
        print("отсутствуют награды")
    }
}

class Person {
    private var communicationSkill: CommunicationSkill!
    private var friendlinessSkill: FriendlinessSkill!
    private var rewardSkill: RewardSkill!

    init(communicationSkill: CommunicationSkill, friendlinessSkill: FriendlinessSkill, rewardSkill: RewardSkill){
        self.communicationSkill = communicationSkill
        self.friendlinessSkill = friendlinessSkill
        self.rewardSkill = rewardSkill
    }

    func performTalk() {
        communicationSkill.talk()
    }

    func performFriendliness() {
        friendlinessSkill.friendliness()
    }

    func performReward() {
        rewardSkill.reward()
    }

    func setCommunicationSkill(cs: CommunicationSkill) {
        self.communicationSkill = cs
    }

    func setFriendlinessSkill(fs: FriendlinessSkill) {
        self.friendlinessSkill = fs
    }

    func setRewardSkill(rs: RewardSkill) {
        self.rewardSkill = rs
    }
}

// кузнец
print("*** создание персонажа ***")
let smith = Person(communicationSkill: Talkative(), friendlinessSkill: Friend(), rewardSkill: RewardYes())
print("Кузнец:")
smith.performTalk()
smith.performFriendliness()
smith.performReward()

// швея
print("*** создание персонажа ***")
let dressmaker = Person(communicationSkill: Silent(), friendlinessSkill: Neutral(), rewardSkill: RewardYes())
print("Швея:")
dressmaker.performTalk()
dressmaker.performFriendliness()
dressmaker.performReward()

// Тюремщик
print("*** создание персонажа ***")
let warder = Person(communicationSkill: Silent(), friendlinessSkill: Enemy(), rewardSkill: RewardNo())
print("Тюремщик:")
warder.performTalk()
warder.performFriendliness()
warder.performReward()


