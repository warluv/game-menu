#pragma compress 1

#include <amxmodx>
#include <reapi>

#pragma semicolon 1

new const GAME_MENU_ID[] = "GameMenu";

public plugin_init() 
{
    register_plugin("Menu Test", "1.0.0", "WarBans");

    register_clcmd("chooseteam", "@Command_GameMenu");

    register_menucmd(register_menuid(GAME_MENU_ID), 1023, "HandlGame_Menu");
}

@Command_GameMenu(id)
{
    if (is_nullent(id))
        return PLUGIN_CONTINUE;

    if (get_member(id, m_iJoiningState) != JOINED)
        return PLUGIN_CONTINUE;

    GameMenu_Show(id);

    return PLUGIN_HANDLED;
}

GameMenu_Show(id)
{
    new keys;
    new len;
    new text[MAX_MENU_LENGTH];

    len += formatex(text[len], charsmax(text) - len, "\yГлавное Меню^n^n");

    len += formatex(text[len], charsmax(text) - len, "\r1. \wСменить команду^n");
    keys |= MENU_KEY_1;

    len += formatex(text[len], charsmax(text) - len, "\r2. \wПолучить деньги^n");
    keys |= MENU_KEY_2;

    len += formatex(text[len], charsmax(text) - len, "\r3. \wМеню способностей^n");
    keys |= MENU_KEY_3;

    len += formatex(text[len], charsmax(text) - len, "\r4. \wМеню оружий^n");
    keys |= MENU_KEY_4;

    len += formatex(text[len], charsmax(text) - len, "^n");
    len += formatex(text[len], charsmax(text) - len, "^n");

    len += formatex(text[len], charsmax(text) - len, "\r0. \wВыход^n");
    keys |= MENU_KEY_0;

    show_menu(id, keys, text, -1, GAME_MENU_ID);
}

@HandlGame_Menu(id, key)
{
    if (key == 9)
        return PLUGIN_HANDLED;

    switch (key)
    {
        case 0: engclient_cmd(id, "chooseteam");
        case 1: amxclient_cmd(id, "money");
        case 2: amxclient_cmd(id, "capabilities");
        case 3: amxclient_cmd(id, "weapon_menu");
    }

    return PLUGIN_HANDLED;
}