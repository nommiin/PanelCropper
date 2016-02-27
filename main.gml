fileList = ds_list_create()
var f = file_find_first("*.jpg",0)
while f != "" {
    ds_list_add(fileList,f)
    f = file_find_next()
}
file_find_close()
panelAlltimeCount = 0
for(var a = 0; a < ds_list_size(fileList); a++) {
    comicRead = sprite_add(fileList[| a],1,false,false,0,0)
    comicSurface = surface_create(sprite_get_width(comicRead),sprite_get_height(comicRead))
    surface_set_target(comicSurface)
    draw_sprite(comicSurface,0,0,0)
    if sprite_get_height(comicRead) == 299 {
        draw_rectangle_colour(600,281,600+300,281+18,c_white,c_white,c_white,c_white,false)
    } else if sprite_get_height(comicRead) == 582 {
        draw_rectangle_colour(604,282,604+300,282+18,c_white,c_white,c_white,c_white,false)
    } else if sprite_get_height(comicRead) == 873 {
        draw_rectangle_colour(604,282,604+300,282+18,c_white,c_white,c_white,c_white,false)
    } else {
        draw_rectangle_colour(604,282,604+300,282+18,c_white,c_white,c_white,c_white,false)
    }
    panelCount = 0
    sW = sprite_get_width(comicRead)
    sH = sprite_get_height(comicRead)
    repeat(24) {
        var findX = sprite_get_width(comicRead)-14, findY = 0;
        do {findY++; findCol = draw_getpixel(findX,findY)} until findCol < 16252928 || findY > sH;
        findX = 0
        do {findX++; findCol = draw_getpixel(findX,findY)} until findCol < 16252928 || findX > sW;
        panelLeft = findX
        panelTop = findY
        do {findY++; findCol = draw_getpixel(findX,findY)} until findCol >= 16252928 || findY > sH; findY--
        panelBottom = findY
        do {findX++; findCol = draw_getpixel(findX,findY)} until findCol >= 16252928 || findX > sW; findX--
        panelRight = findX
        if (panelRight-panelLeft) >= 64 && (panelBottom-panelTop) >= 64 {
            surface_save_part(comicSurface,"all_panels/panel" + string(panelAlltimeCount) + ".png",panelLeft,panelTop,panelRight-panelLeft,panelBottom-panelTop)
            panelCount++
            panelAlltimeCount++ 
        }
        draw_rectangle_colour(panelLeft-2,panelTop-2,panelRight+2,panelBottom+2,c_white,c_white,c_white,c_white,false)
    }
    surface_save(comicSurface,"all_finals/final_image_" + string(panelAlltimeCount) + ".png")
    surface_reset_target()
    surface_free(comicSurface)
    sprite_delete(comicRead)
}
ds_list_destroy(fileList)
