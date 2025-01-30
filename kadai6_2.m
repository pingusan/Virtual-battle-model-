C1.HP = 35
C1.Name = "Pikachu";
C1.Skill = struct("Thunderbolt",9,"Tail",10);
C2.HP = 44;
C2.Name = "Squirtle";
C2.Skill = struct("WaterGun",4,"Hydropump",11);
result = battle2(C1,C2);
disp(result.Win);

function result = battle2(C1,C2)

    HP1 = [];
    HP2 = [];
    C1.XP = 0;
    C1.Level = 1;
    C2.XP = 0;
    C2.Level = 1;
    

    while C1.HP * C2.HP > 0
        [C1.HP,C2.HP] = attack(C1,C2);
        HP1 = [HP1 C1.HP];
        HP2 = [HP2 C2.HP];
    end

    result.HP1 = HP1;
    result.HP2 = HP2;

    XP_PER_WIN = struct('Pikachu', 50, 'Squirtle', 80);
    XP_PER_LEVEL = 30;

    if C1.HP * C2.HP == 0
        if C1.HP > C2.HP
            fprintf("%sの勝ち\n", C1.Name)
            result.Win = C1.Name;
            C1.XP = C1.XP + XP_PER_WIN.(C2.Name);
        else
            fprintf("%sの勝ち\n", C2.Name)
            result.Win = C2.Name;
            C2.XP = C2.XP + XP_PER_WIN.(C1.Name);
        end
    end

    if isfield(result, 'Win')
        if strcmp(result.Win, C1.Name)
            levels_up = floor(C1.XP / XP_PER_LEVEL);
            fprintf('%sは%dレベル上がった\n', C1.Name, levels_up);
            C1.Level = C1.Level + levels_up;
            C1.XP = mod(C1.XP, XP_PER_LEVEL);
        elseif strcmp(result.Win, C2.Name)
            levels_up = floor(C2.XP / XP_PER_LEVEL);
            fprintf('%sは%dレベル上がった\n', C2.Name, levels_up);
            C2.Level = C2.Level + levels_up;
            C2.XP = mod(C2.XP, XP_PER_LEVEL);
        end
    end

end

function [a,b] = attack(C1,C2)
    if round(rand) == 0
        s = string(fieldnames(C1.Skill));
        damage = C1.Skill.(s(round(rand) + 1));
        HP2 = C2.HP;
        HP2 = HP2 - damage;
        b = HP2;
        a = C1.HP;
        fprintf("%sから%sへの攻撃：%dのダメージ\n", C1.Name, C2.Name, damage);
    else
        s = string(fieldnames(C2.Skill));
        damage = C2.Skill.(s(round(rand) + 1));
        HP1 = C1.HP;
        HP1 = HP1 - damage;
        a = HP1;
        b = C2.HP;
        fprintf("%sから%sへの攻撃：%dのダメージ\n", C2.Name, C1.Name, damage);
    end

    if b * a < 0
        if a > b
            b = 0;
        else
            a = 0;
        end
    end
end