-- Decompiled with Potassium's decompiler.

local script_Base64 = require(script.Base64);
local v1 = ipairs;
local bit32_band = bit32.band;
local bit32_bor = bit32.bor;
local bit32_bxor = bit32.bxor;
local bit32_lshift = bit32.lshift;
local bit32_rshift = bit32.rshift;
local bit32_lrotate = bit32.lrotate;
local bit32_rrotate = bit32.rrotate;
local u2 = {};
local u3 = {};
local v4 = {};
local v5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = { 0, 0, 0, 0, 0, 0, 0, 0, 28, 25, 26, 27, 0, 0, 10, 9, 11, 12, 0, 15, 16, 17, 18, 0, 20, 22, 23, 21 };
local u10 = {};
local v11 = v5;
local v12 = v4;
local v13 = 4;
local v14 = { 4, 1, 2, -2, 2 };
local u15 = { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 };

local function md5_feed_64(p16, p17, p18, p19) -- Line: 278
    -- upvalues: u10 (copy), u8 (copy), u9 (copy), bit32_band (copy), bit32_rrotate (copy), bit32_bxor (copy), bit32_bor (copy)
    local v20 = u10;
    local v21 = u8;
    local v22 = u9;
    local v23 = p16[1];
    local v24 = p16[2];
    local v25 = p16[3];
    local v26 = p16[4];

    for i = p18, p18 + p19 - 1, 64 do
        local v27 = i;
        local v28 = v27;
        local v29 = v27;
        v27 = v28;
        v29 = v28;

        for i2 = 1, 16 do
            v28 = v28 + 4;
            local string_byte_ret, v30, v31, v32 = string.byte(p17, v28 - 3, v28);
            v20[i2] = ((v32 * 256 + v31) * 256 + v30) * 256 + string_byte_ret;
            local _ = i2;
        end;

        local v33 = v25;
        local v34 = v26;
        local v35 = v24;
        local v36 = v23;
        local v37 = 25;

        for i2 = 1, 16 do
            local v38 = bit32_rrotate(bit32_band(v24, v25) + bit32_band(-1 - v24, v26) + v23 + v21[i2] + v20[i2], v37) + v24;
            v37 = v22[v37];
            v23 = v26;
            v26 = v25;
            v25 = v24;
            v24 = v38;
            local _ = i2;
        end;

        local v39 = 27;

        for i2 = 17, 32 do
            local v40 = bit32_rrotate(bit32_band(v26, v24) + bit32_band(-1 - v26, v25) + v23 + v21[i2] + v20[(i2 * 5 - 4) % 16 + 1], v39) + v24;
            v39 = v22[v39];
            v23 = v26;
            v26 = v25;
            v25 = v24;
            v24 = v40;
            local _ = i2;
        end;

        local v41 = 28;

        for i2 = 33, 48 do
            local v42 = bit32_rrotate(bit32_bxor(bit32_bxor(v24, v25), v26) + v23 + v21[i2] + v20[(i2 * 3 + 2) % 16 + 1], v41) + v24;
            v41 = v22[v41];
            v23 = v26;
            v26 = v25;
            v25 = v24;
            v24 = v42;
            local _ = i2;
        end;

        local v43 = 26;

        for i2 = 49, 64 do
            local v44 = bit32_rrotate(bit32_bxor(v25, (bit32_bor(v24, -1 - v26))) + v23 + v21[i2] + v20[(i2 * 7 - 7) % 16 + 1], v43) + v24;
            v43 = v22[v43];
            v23 = v26;
            v26 = v25;
            v25 = v24;
            v24 = v44;
            local _ = i2;
        end;

        v23 = (v23 + v36) % 4294967296;
        v24 = (v24 + v35) % 4294967296;
        v25 = (v25 + v33) % 4294967296;
        v26 = (v26 + v34) % 4294967296;
    end;

    p16[1] = v23;
    p16[2] = v24;
    p16[3] = v25;
    p16[4] = v26;
end;

local function sha1_feed_64(p45, p46, p47, p48) -- Line: 339
    -- upvalues: u10 (copy), bit32_bxor (copy), bit32_lrotate (copy), bit32_band (copy), bit32_rrotate (copy)
    local v49 = u10;
    local v50 = p45[1];
    local v51 = p45[2];
    local v52 = p45[3];
    local v53 = p45[4];
    local v54 = p45[5];

    for i = p47, p47 + p48 - 1, 64 do
        local v55 = i;
        local v56 = v55;
        local v57 = v55;
        v55 = v56;
        v57 = v56;

        for i2 = 1, 16 do
            v56 = v56 + 4;
            local string_byte_ret, v58, v59, v60 = string.byte(p46, v56 - 3, v56);
            v49[i2] = ((string_byte_ret * 256 + v58) * 256 + v59) * 256 + v60;
            local _ = i2;
        end;

        for i2 = 17, 80 do
            v49[i2] = bit32_lrotate(bit32_bxor(v49[i2 - 3], v49[i2 - 8], v49[i2 - 14], v49[i2 - 16]), 1);
            local _ = i2;
        end;

        local v61 = v53;
        local v62 = v52;
        local v63 = v51;
        local v64 = v50;
        local v65 = v54;

        for i2 = 1, 20 do
            local v66 = bit32_lrotate(v50, 5) + bit32_band(v51, v52) + bit32_band(-1 - v51, v53) + 1518500249 + v49[i2] + v54;
            local v67 = bit32_rrotate(v51, 2);
            v51 = v50;
            v50 = v66;
            v54 = v53;
            v53 = v52;
            v52 = v67;
            local _ = i2;
        end;

        for i2 = 21, 40 do
            local v68 = bit32_lrotate(v50, 5) + bit32_bxor(v51, v52, v53) + 1859775393 + v49[i2] + v54;
            local v69 = bit32_rrotate(v51, 2);
            v51 = v50;
            v50 = v68;
            v54 = v53;
            v53 = v52;
            v52 = v69;
            local _ = i2;
        end;

        for i2 = 41, 60 do
            local v70 = bit32_lrotate(v50, 5) + bit32_band(v53, v52) + bit32_band(v51, (bit32_bxor(v53, v52))) + 2400959708 + v49[i2] + v54;
            local v71 = bit32_rrotate(v51, 2);
            v51 = v50;
            v50 = v70;
            v54 = v53;
            v53 = v52;
            v52 = v71;
            local _ = i2;
        end;

        for i2 = 61, 80 do
            local v72 = bit32_lrotate(v50, 5) + bit32_bxor(v51, v52, v53) + 3395469782 + v49[i2] + v54;
            local v73 = bit32_rrotate(v51, 2);
            v51 = v50;
            v50 = v72;
            v54 = v53;
            v53 = v52;
            v52 = v73;
            local _ = i2;
        end;

        v50 = (v50 + v64) % 4294967296;
        v51 = (v51 + v63) % 4294967296;
        v52 = (v52 + v62) % 4294967296;
        v53 = (v53 + v61) % 4294967296;
        v54 = (v54 + v65) % 4294967296;
    end;

    p45[1] = v50;
    p45[2] = v51;
    p45[3] = v52;
    p45[4] = v53;
    p45[5] = v54;
end;

local u74 = {
    [224] = {},
    [256] = v5
};

local function keccak_feed(p75, p76, p77, p78, p79, p80) -- Line: 401
    -- upvalues: u6 (copy), u7 (copy), bit32_bxor (copy), bit32_band (copy)
    local v81 = u6;
    local v82 = u7;
    local v83 = p80 / 8;

    for i = p78, p78 + p79 - 1, p80 do
        local v84 = i;
        local v85 = v84;
        local v86 = v84;
        v84 = v85;
        v86 = v85;

        for i2 = 1, v83 do
            local string_byte_ret, v87, v88, v89 = string.byte(p77, v85 + 1, v85 + 4);
            p75[i2] = bit32_bxor(p75[i2], ((v89 * 256 + v88) * 256 + v87) * 256 + string_byte_ret);
            v85 = v85 + 8;
            local string_byte_ret2, v90, v91, v92 = string.byte(p77, v85 - 3, v85);
            p76[i2] = bit32_bxor(p76[i2], ((v92 * 256 + v91) * 256 + v90) * 256 + string_byte_ret2);
            local _ = i2;
        end;

        local v93 = p75[1];
        local v94 = p76[1];
        local v95 = p75[2];
        local v96 = p76[2];
        local v97 = p75[3];
        local v98 = p76[3];
        local v99 = p75[4];
        local v100 = p76[4];
        local v101 = p75[5];
        local v102 = p76[5];
        local v103 = p75[6];
        local v104 = p76[6];
        local v105 = p75[7];
        local v106 = p76[7];
        local v107 = p75[8];
        local v108 = p76[8];
        local v109 = p75[9];
        local v110 = p76[9];
        local v111 = p75[10];
        local v112 = p76[10];
        local v113 = p75[11];
        local v114 = p76[11];
        local v115 = p75[12];
        local v116 = p76[12];
        local v117 = p75[13];
        local v118 = p76[13];
        local v119 = p75[14];
        local v120 = p76[14];
        local v121 = p75[15];
        local v122 = p76[15];
        local v123 = p75[16];
        local v124 = p76[16];
        local v125 = p75[17];
        local v126 = p76[17];
        local v127 = p75[18];
        local v128 = p76[18];
        local v129 = p75[19];
        local v130 = p76[19];
        local v131 = p75[20];
        local v132 = p76[20];
        local v133 = p75[21];
        local v134 = p76[21];
        local v135 = p75[22];
        local v136 = p76[22];
        local v137 = p75[23];
        local v138 = p76[23];
        local v139 = p75[24];
        local v140 = p76[24];
        local v141 = p75[25];
        local v142 = p76[25];

        for i2 = 1, 24 do
            local v143 = bit32_bxor(v93, v103, v113, v123, v133);
            local v144 = bit32_bxor(v94, v104, v114, v124, v134);
            local v145 = bit32_bxor(v95, v105, v115, v125, v135);
            local v146 = bit32_bxor(v96, v106, v116, v126, v136);
            local v147 = bit32_bxor(v97, v107, v117, v127, v137);
            local v148 = bit32_bxor(v98, v108, v118, v128, v138);
            local v149 = bit32_bxor(v99, v109, v119, v129, v139);
            local v150 = bit32_bxor(v100, v110, v120, v130, v140);
            local v151 = bit32_bxor(v101, v111, v121, v131, v141);
            local v152 = bit32_bxor(v102, v112, v122, v132, v142);
            local v153 = bit32_bxor(v143, v147 * 2 + (v148 % 4294967296 - v148 % 2147483648) / 2147483648);
            local v154 = bit32_bxor(v144, v148 * 2 + (v147 % 4294967296 - v147 % 2147483648) / 2147483648);
            local v155 = bit32_bxor(v153, v95);
            local v156 = bit32_bxor(v154, v96);
            local v157 = bit32_bxor(v153, v105);
            local v158 = bit32_bxor(v154, v106);
            local v159 = bit32_bxor(v153, v115);
            local v160 = bit32_bxor(v154, v116);
            local v161 = bit32_bxor(v153, v125);
            local v162 = bit32_bxor(v154, v126);
            local v163 = bit32_bxor(v153, v135);
            local v164 = bit32_bxor(v154, v136);
            local v165 = (v157 % 4294967296 - v157 % 1048576) / 1048576 + v158 * 4096;
            local v166 = (v158 % 4294967296 - v158 % 1048576) / 1048576 + v157 * 4096;
            local v167 = (v161 % 4294967296 - v161 % 524288) / 524288 + v162 * 8192;
            local v168 = (v162 % 4294967296 - v162 % 524288) / 524288 + v161 * 8192;
            local v169 = v155 * 2 + (v156 % 4294967296 - v156 % 2147483648) / 2147483648;
            local v170 = v156 * 2 + (v155 % 4294967296 - v155 % 2147483648) / 2147483648;
            local v171 = v159 * 1024 + (v160 % 4294967296 - v160 % 4194304) / 4194304;
            local v172 = v160 * 1024 + (v159 % 4294967296 - v159 % 4194304) / 4194304;
            local v173 = v163 * 4 + (v164 % 4294967296 - v164 % 1073741824) / 1073741824;
            local v174 = v164 * 4 + (v163 % 4294967296 - v163 % 1073741824) / 1073741824;
            local v175 = bit32_bxor(v145, v149 * 2 + (v150 % 4294967296 - v150 % 2147483648) / 2147483648);
            local v176 = bit32_bxor(v146, v150 * 2 + (v149 % 4294967296 - v149 % 2147483648) / 2147483648);
            local v177 = bit32_bxor(v175, v97);
            local v178 = bit32_bxor(v176, v98);
            local v179 = bit32_bxor(v175, v107);
            local v180 = bit32_bxor(v176, v108);
            local v181 = bit32_bxor(v175, v117);
            local v182 = bit32_bxor(v176, v118);
            local v183 = bit32_bxor(v175, v127);
            local v184 = bit32_bxor(v176, v128);
            local v185 = bit32_bxor(v175, v137);
            local v186 = bit32_bxor(v176, v138);
            local v187 = (v181 % 4294967296 - v181 % 2097152) / 2097152 + v182 * 2048;
            local v188 = (v182 % 4294967296 - v182 % 2097152) / 2097152 + v181 * 2048;
            local v189 = (v185 % 4294967296 - v185 % 8) / 8 + v186 * 536870912 % 4294967296;
            local v190 = (v186 % 4294967296 - v186 % 8) / 8 + v185 * 536870912 % 4294967296;
            local v191 = v179 * 64 + (v180 % 4294967296 - v180 % 67108864) / 67108864;
            local v192 = v180 * 64 + (v179 % 4294967296 - v179 % 67108864) / 67108864;
            local v193 = v183 * 32768 + (v184 % 4294967296 - v184 % 131072) / 131072;
            local v194 = v184 * 32768 + (v183 % 4294967296 - v183 % 131072) / 131072;
            local v195 = (v177 % 4294967296 - v177 % 4) / 4 + v178 * 1073741824 % 4294967296;
            local v196 = (v178 % 4294967296 - v178 % 4) / 4 + v177 * 1073741824 % 4294967296;
            local v197 = bit32_bxor(v147, v151 * 2 + (v152 % 4294967296 - v152 % 2147483648) / 2147483648);
            local v198 = bit32_bxor(v148, v152 * 2 + (v151 % 4294967296 - v151 % 2147483648) / 2147483648);
            local v199 = bit32_bxor(v197, v99);
            local v200 = bit32_bxor(v198, v100);
            local v201 = bit32_bxor(v197, v109);
            local v202 = bit32_bxor(v198, v110);
            local v203 = bit32_bxor(v197, v119);
            local v204 = bit32_bxor(v198, v120);
            local v205 = bit32_bxor(v197, v129);
            local v206 = bit32_bxor(v198, v130);
            local v207 = bit32_bxor(v197, v139);
            local v208 = bit32_bxor(v198, v140);
            local v209 = v205 * 2097152 % 4294967296 + (v206 % 4294967296 - v206 % 2048) / 2048;
            local v210 = v206 * 2097152 % 4294967296 + (v205 % 4294967296 - v205 % 2048) / 2048;
            local v211 = v199 * 268435456 % 4294967296 + (v200 % 4294967296 - v200 % 16) / 16;
            local v212 = v200 * 268435456 % 4294967296 + (v199 % 4294967296 - v199 % 16) / 16;
            local v213 = v203 * 33554432 % 4294967296 + (v204 % 4294967296 - v204 % 128) / 128;
            local v214 = v204 * 33554432 % 4294967296 + (v203 % 4294967296 - v203 % 128) / 128;
            local v215 = (v207 % 4294967296 - v207 % 256) / 256 + v208 * 16777216 % 4294967296;
            local v216 = (v208 % 4294967296 - v208 % 256) / 256 + v207 * 16777216 % 4294967296;
            local v217 = (v201 % 4294967296 - v201 % 512) / 512 + v202 * 8388608 % 4294967296;
            local v218 = (v202 % 4294967296 - v202 % 512) / 512 + v201 * 8388608 % 4294967296;
            local v219 = bit32_bxor(v149, v143 * 2 + (v144 % 4294967296 - v144 % 2147483648) / 2147483648);
            local v220 = bit32_bxor(v150, v144 * 2 + (v143 % 4294967296 - v143 % 2147483648) / 2147483648);
            local v221 = bit32_bxor(v219, v101);
            local v222 = bit32_bxor(v220, v102);
            local v223 = bit32_bxor(v219, v111);
            local v224 = bit32_bxor(v220, v112);
            local v225 = bit32_bxor(v219, v121);
            local v226 = bit32_bxor(v220, v122);
            local v227 = bit32_bxor(v219, v131);
            local v228 = bit32_bxor(v220, v132);
            local v229 = bit32_bxor(v219, v141);
            local v230 = bit32_bxor(v220, v142);
            local v231 = v229 * 16384 + (v230 % 4294967296 - v230 % 262144) / 262144;
            local v232 = v230 * 16384 + (v229 % 4294967296 - v229 % 262144) / 262144;
            local v233 = v223 * 1048576 % 4294967296 + (v224 % 4294967296 - v224 % 4096) / 4096;
            local v234 = v224 * 1048576 % 4294967296 + (v223 % 4294967296 - v223 % 4096) / 4096;
            local v235 = v227 * 256 + (v228 % 4294967296 - v228 % 16777216) / 16777216;
            local v236 = v228 * 256 + (v227 % 4294967296 - v227 % 16777216) / 16777216;
            local v237 = v221 * 134217728 % 4294967296 + (v222 % 4294967296 - v222 % 32) / 32;
            local v238 = v222 * 134217728 % 4294967296 + (v221 % 4294967296 - v221 % 32) / 32;
            local v239 = (v225 % 4294967296 - v225 % 33554432) / 33554432 + v226 * 128;
            local v240 = (v226 % 4294967296 - v226 % 33554432) / 33554432 + v225 * 128;
            local v241 = bit32_bxor(v151, v145 * 2 + (v146 % 4294967296 - v146 % 2147483648) / 2147483648);
            local v242 = bit32_bxor(v152, v146 * 2 + (v145 % 4294967296 - v145 % 2147483648) / 2147483648);
            local v243 = bit32_bxor(v241, v103);
            local v244 = bit32_bxor(v242, v104);
            local v245 = bit32_bxor(v241, v113);
            local v246 = bit32_bxor(v242, v114);
            local v247 = bit32_bxor(v241, v123);
            local v248 = bit32_bxor(v242, v124);
            local v249 = bit32_bxor(v241, v133);
            local v250 = bit32_bxor(v242, v134);
            local v251 = v245 * 8 + (v246 % 4294967296 - v246 % 536870912) / 536870912;
            local v252 = v246 * 8 + (v245 % 4294967296 - v245 % 536870912) / 536870912;
            local v253 = v249 * 262144 + (v250 % 4294967296 - v250 % 16384) / 16384;
            local v254 = v250 * 262144 + (v249 % 4294967296 - v249 % 16384) / 16384;
            local v255 = (v243 % 4294967296 - v243 % 268435456) / 268435456 + v244 * 16;
            local v256 = (v244 % 4294967296 - v244 % 268435456) / 268435456 + v243 * 16;
            local v257 = (v247 % 4294967296 - v247 % 8388608) / 8388608 + v248 * 512;
            local v258 = (v248 % 4294967296 - v248 % 8388608) / 8388608 + v247 * 512;
            local v259 = bit32_bxor(v241, v93);
            local v260 = bit32_bxor(v242, v94);
            local v261 = bit32_bxor(v259, (bit32_band(-1 - v165, v187)));
            v95 = bit32_bxor(v165, (bit32_band(-1 - v187, v209)));
            v97 = bit32_bxor(v187, (bit32_band(-1 - v209, v231)));
            v99 = bit32_bxor(v209, (bit32_band(-1 - v231, v259)));
            v101 = bit32_bxor(v231, (bit32_band(-1 - v259, v165)));
            local v262 = bit32_bxor(v260, (bit32_band(-1 - v166, v188)));
            v96 = bit32_bxor(v166, (bit32_band(-1 - v188, v210)));
            v98 = bit32_bxor(v188, (bit32_band(-1 - v210, v232)));
            v100 = bit32_bxor(v210, (bit32_band(-1 - v232, v260)));
            v102 = bit32_bxor(v232, (bit32_band(-1 - v260, v166)));
            v103 = bit32_bxor(v211, (bit32_band(-1 - v233, v251)));
            v105 = bit32_bxor(v233, (bit32_band(-1 - v251, v167)));
            v107 = bit32_bxor(v251, (bit32_band(-1 - v167, v189)));
            v109 = bit32_bxor(v167, (bit32_band(-1 - v189, v211)));
            v111 = bit32_bxor(v189, (bit32_band(-1 - v211, v233)));
            v104 = bit32_bxor(v212, (bit32_band(-1 - v234, v252)));
            v106 = bit32_bxor(v234, (bit32_band(-1 - v252, v168)));
            v108 = bit32_bxor(v252, (bit32_band(-1 - v168, v190)));
            v110 = bit32_bxor(v168, (bit32_band(-1 - v190, v212)));
            v112 = bit32_bxor(v190, (bit32_band(-1 - v212, v234)));
            v113 = bit32_bxor(v169, (bit32_band(-1 - v191, v213)));
            v115 = bit32_bxor(v191, (bit32_band(-1 - v213, v235)));
            v117 = bit32_bxor(v213, (bit32_band(-1 - v235, v253)));
            v119 = bit32_bxor(v235, (bit32_band(-1 - v253, v169)));
            v121 = bit32_bxor(v253, (bit32_band(-1 - v169, v191)));
            v114 = bit32_bxor(v170, (bit32_band(-1 - v192, v214)));
            v116 = bit32_bxor(v192, (bit32_band(-1 - v214, v236)));
            v118 = bit32_bxor(v214, (bit32_band(-1 - v236, v254)));
            v120 = bit32_bxor(v236, (bit32_band(-1 - v254, v170)));
            v122 = bit32_bxor(v254, (bit32_band(-1 - v170, v192)));
            v123 = bit32_bxor(v237, (bit32_band(-1 - v255, v171)));
            v125 = bit32_bxor(v255, (bit32_band(-1 - v171, v193)));
            v127 = bit32_bxor(v171, (bit32_band(-1 - v193, v215)));
            v129 = bit32_bxor(v193, (bit32_band(-1 - v215, v237)));
            v131 = bit32_bxor(v215, (bit32_band(-1 - v237, v255)));
            v124 = bit32_bxor(v238, (bit32_band(-1 - v256, v172)));
            v126 = bit32_bxor(v256, (bit32_band(-1 - v172, v194)));
            v128 = bit32_bxor(v172, (bit32_band(-1 - v194, v216)));
            v130 = bit32_bxor(v194, (bit32_band(-1 - v216, v238)));
            v132 = bit32_bxor(v216, (bit32_band(-1 - v238, v256)));
            v133 = bit32_bxor(v195, (bit32_band(-1 - v217, v239)));
            v135 = bit32_bxor(v217, (bit32_band(-1 - v239, v257)));
            v137 = bit32_bxor(v239, (bit32_band(-1 - v257, v173)));
            v139 = bit32_bxor(v257, (bit32_band(-1 - v173, v195)));
            v141 = bit32_bxor(v173, (bit32_band(-1 - v195, v217)));
            v134 = bit32_bxor(v196, (bit32_band(-1 - v218, v240)));
            v136 = bit32_bxor(v218, (bit32_band(-1 - v240, v258)));
            v138 = bit32_bxor(v240, (bit32_band(-1 - v258, v174)));
            v140 = bit32_bxor(v258, (bit32_band(-1 - v174, v196)));
            v142 = bit32_bxor(v174, (bit32_band(-1 - v196, v218)));
            v93 = bit32_bxor(v261, v81[i2]);
            v94 = v262 + v82[i2];
            local _ = i2;
        end;

        p75[1] = v93;
        p76[1] = v94;
        p75[2] = v95;
        p76[2] = v96;
        p75[3] = v97;
        p76[3] = v98;
        p75[4] = v99;
        p76[4] = v100;
        p75[5] = v101;
        p76[5] = v102;
        p75[6] = v103;
        p76[6] = v104;
        p75[7] = v105;
        p76[7] = v106;
        p75[8] = v107;
        p76[8] = v108;
        p75[9] = v109;
        p76[9] = v110;
        p75[10] = v111;
        p76[10] = v112;
        p75[11] = v113;
        p76[11] = v114;
        p75[12] = v115;
        p76[12] = v116;
        p75[13] = v117;
        p76[13] = v118;
        p75[14] = v119;
        p76[14] = v120;
        p75[15] = v121;
        p76[15] = v122;
        p75[16] = v123;
        p76[16] = v124;
        p75[17] = v125;
        p76[17] = v126;
        p75[18] = v127;
        p76[18] = v128;
        p75[19] = v129;
        p76[19] = v130;
        p75[20] = v131;
        p76[20] = v132;
        p75[21] = v133;
        p76[21] = v134;
        p75[22] = v135;
        p76[22] = v136;
        p75[23] = v137;
        p76[23] = v138;
        p75[24] = v139;
        p76[24] = v140;
        p75[25] = v141;
        p76[25] = v142;
    end;
end;

local function sha256_feed_64(p263, p264, p265, p266) -- Line: 151
    -- upvalues: u10 (copy), u3 (copy), bit32_rrotate (copy), bit32_lrotate (copy), bit32_rshift (copy), bit32_bxor (copy), bit32_band (copy)
    local v267 = u10;
    local v268 = u3;
    local v269 = p263[1];
    local v270 = p263[2];
    local v271 = p263[3];
    local v272 = p263[4];
    local v273 = p263[5];
    local v274 = p263[6];
    local v275 = p263[7];
    local v276 = p263[8];

    for i = p265, p265 + p266 - 1, 64 do
        local v277 = i;
        local v278 = v277;
        local v279 = v277;
        v277 = v278;
        v279 = v278;

        for i2 = 1, 16 do
            v278 = v278 + 4;
            local string_byte_ret, v280, v281, v282 = string.byte(p264, v278 - 3, v278);
            v267[i2] = ((string_byte_ret * 256 + v280) * 256 + v281) * 256 + v282;
            local _ = i2;
        end;

        for i2 = 17, 64 do
            local v283 = v267[i2 - 15];
            local v284 = v267[i2 - 2];
            v267[i2] = bit32_bxor(bit32_rrotate(v283, 7), bit32_lrotate(v283, 14), (bit32_rshift(v283, 3))) + bit32_bxor(bit32_lrotate(v284, 15), bit32_lrotate(v284, 13), (bit32_rshift(v284, 10))) + v267[i2 - 7] + v267[i2 - 16];
            local _ = i2;
        end;

        local v285 = v270;
        local v286 = v275;
        local v287 = v274;
        local v288 = v272;
        local v289 = v271;
        local v290 = v269;
        local v291 = v273;
        local v292 = v276;

        for i2 = 1, 64 do
            local v293 = bit32_bxor(bit32_rrotate(v273, 6), bit32_rrotate(v273, 11), (bit32_lrotate(v273, 7))) + bit32_band(v273, v274) + bit32_band(-1 - v273, v275) + v276 + v268[i2] + v267[i2];
            local v294 = v293 + bit32_band(v271, v270) + bit32_band(v269, (bit32_bxor(v271, v270))) + bit32_bxor(bit32_rrotate(v269, 2), bit32_rrotate(v269, 13), (bit32_lrotate(v269, 10)));
            v276 = v275;
            v275 = v274;
            v274 = v273;
            v273 = v293 + v272;
            v272 = v271;
            v271 = v270;
            v270 = v269;
            v269 = v294;
            local _ = i2;
        end;

        v269 = (v269 + v290) % 4294967296;
        v270 = (v270 + v285) % 4294967296;
        v271 = (v271 + v289) % 4294967296;
        v272 = (v272 + v288) % 4294967296;
        v273 = (v273 + v291) % 4294967296;
        v274 = (v274 + v287) % 4294967296;
        v275 = (v275 + v286) % 4294967296;
        v276 = (v276 + v292) % 4294967296;
    end;

    p263[1] = v269;
    p263[2] = v270;
    p263[3] = v271;
    p263[4] = v272;
    p263[5] = v273;
    p263[6] = v274;
    p263[7] = v275;
    p263[8] = v276;
end;

local function sha512_feed_128(p295, p296, p297, p298, p299) -- Line: 187
    -- upvalues: u10 (copy), u2 (copy), u3 (copy), bit32_rshift (copy), bit32_lshift (copy), bit32_bxor (copy), bit32_band (copy)
    local v300 = u10;
    local v301 = u2;
    local v302 = u3;
    local v303 = p295[1];
    local v304 = p295[2];
    local v305 = p295[3];
    local v306 = p295[4];
    local v307 = p295[5];
    local v308 = p295[6];
    local v309 = p295[7];
    local v310 = p295[8];
    local v311 = p296[1];
    local v312 = p296[2];
    local v313 = p296[3];
    local v314 = p296[4];
    local v315 = p296[5];
    local v316 = p296[6];
    local v317 = p296[7];
    local v318 = p296[8];

    for i = p298, p298 + p299 - 1, 128 do
        local v319 = i;
        local v320 = v319;
        local v321 = v319;
        v319 = v320;
        v321 = v320;

        for i2 = 1, 32 do
            v320 = v320 + 4;
            local string_byte_ret, v322, v323, v324 = string.byte(p297, v320 - 3, v320);
            v300[i2] = ((string_byte_ret * 256 + v322) * 256 + v323) * 256 + v324;
            local _ = i2;
        end;

        for i2 = 34, 160, 2 do
            local v325 = v300[i2 - 30];
            local v326 = v300[i2 - 31];
            local v327 = v300[i2 - 4];
            local v328 = v300[i2 - 5];
            local v329 = bit32_bxor(bit32_rshift(v325, 1) + bit32_lshift(v326, 31), bit32_rshift(v325, 8) + bit32_lshift(v326, 24), bit32_rshift(v325, 7) + bit32_lshift(v326, 25)) % 4294967296 + bit32_bxor(bit32_rshift(v327, 19) + bit32_lshift(v328, 13), bit32_lshift(v327, 3) + bit32_rshift(v328, 29), bit32_rshift(v327, 6) + bit32_lshift(v328, 26)) % 4294967296 + v300[i2 - 14] + v300[i2 - 32];
            local v330 = v329 % 4294967296;
            v300[i2 - 1] = bit32_bxor(bit32_rshift(v326, 1) + bit32_lshift(v325, 31), bit32_rshift(v326, 8) + bit32_lshift(v325, 24), (bit32_rshift(v326, 7))) + bit32_bxor(bit32_rshift(v328, 19) + bit32_lshift(v327, 13), bit32_lshift(v328, 3) + bit32_rshift(v327, 29), (bit32_rshift(v328, 6))) + v300[i2 - 15] + v300[i2 - 33] + (v329 - v330) / 4294967296;
            v300[i2] = v330;
            local _ = i2;
        end;

        local v331 = v303;
        local v332 = v306;
        local v333 = v314;
        local v334 = v304;
        local v335 = v311;
        local v336 = v317;
        local v337 = v318;
        local v338 = v305;
        local v339 = v310;
        local v340 = v316;
        local v341 = v308;
        local v342 = v315;
        local v343 = v307;
        local v344 = v312;
        local v345 = v313;
        local v346 = v309;

        for i2 = 1, 80 do
            local v347 = i2 * 2;
            local v348 = bit32_bxor(bit32_rshift(v307, 14) + bit32_lshift(v315, 18), bit32_rshift(v307, 18) + bit32_lshift(v315, 14), bit32_lshift(v307, 23) + bit32_rshift(v315, 9)) % 4294967296 + (bit32_band(v307, v308) + bit32_band(-1 - v307, v309)) % 4294967296 + v310 + v301[i2] + v300[v347];
            local v349 = v348 % 4294967296;
            local v350 = bit32_bxor(bit32_rshift(v315, 14) + bit32_lshift(v307, 18), bit32_rshift(v315, 18) + bit32_lshift(v307, 14), bit32_lshift(v315, 23) + bit32_rshift(v307, 9)) + bit32_band(v315, v316) + bit32_band(-1 - v315, v317) + v318 + v302[i2] + v300[v347 - 1] + (v348 - v349) / 4294967296;
            local v351 = v349 + v306;
            local v352 = v351 % 4294967296;
            local v353 = v350 + v314 + (v351 - v352) / 4294967296;
            local v354 = v349 + (bit32_band(v305, v304) + bit32_band(v303, (bit32_bxor(v305, v304)))) % 4294967296 + bit32_bxor(bit32_rshift(v303, 28) + bit32_lshift(v311, 4), bit32_lshift(v303, 30) + bit32_rshift(v311, 2), bit32_lshift(v303, 25) + bit32_rshift(v311, 7)) % 4294967296;
            local v355 = v354 % 4294967296;
            local v356 = v350 + (bit32_band(v313, v312) + bit32_band(v311, (bit32_bxor(v313, v312)))) + bit32_bxor(bit32_rshift(v311, 28) + bit32_lshift(v303, 4), bit32_lshift(v311, 30) + bit32_rshift(v303, 2), bit32_lshift(v311, 25) + bit32_rshift(v303, 7)) + (v354 - v355) / 4294967296;
            v310 = v309;
            v309 = v308;
            v308 = v307;
            v307 = v352;
            v314 = v313;
            v313 = v312;
            v312 = v311;
            v311 = v356;
            v318 = v317;
            v317 = v316;
            v316 = v315;
            v315 = v353;
            v306 = v305;
            v305 = v304;
            v304 = v303;
            v303 = v355;
            local _ = i2;
        end;

        local v357 = v331 + v303;
        v303 = v357 % 4294967296;
        v311 = (v335 + v311 + (v357 - v303) / 4294967296) % 4294967296;
        local v358 = v334 + v304;
        v304 = v358 % 4294967296;
        v312 = (v344 + v312 + (v358 - v304) / 4294967296) % 4294967296;
        local v359 = v338 + v305;
        v305 = v359 % 4294967296;
        v313 = (v345 + v313 + (v359 - v305) / 4294967296) % 4294967296;
        local v360 = v332 + v306;
        v306 = v360 % 4294967296;
        v314 = (v333 + v314 + (v360 - v306) / 4294967296) % 4294967296;
        local v361 = v343 + v307;
        v307 = v361 % 4294967296;
        v315 = (v342 + v315 + (v361 - v307) / 4294967296) % 4294967296;
        local v362 = v341 + v308;
        v308 = v362 % 4294967296;
        v316 = (v340 + v316 + (v362 - v308) / 4294967296) % 4294967296;
        local v363 = v346 + v309;
        v309 = v363 % 4294967296;
        v317 = (v336 + v317 + (v363 - v309) / 4294967296) % 4294967296;
        local v364 = v339 + v310;
        v310 = v364 % 4294967296;
        v318 = (v337 + v318 + (v364 - v310) / 4294967296) % 4294967296;
    end;

    p295[1] = v303;
    p295[2] = v304;
    p295[3] = v305;
    p295[4] = v306;
    p295[5] = v307;
    p295[6] = v308;
    p295[7] = v309;
    p295[8] = v310;
    p296[1] = v311;
    p296[2] = v312;
    p296[3] = v313;
    p296[4] = v314;
    p296[5] = v315;
    p296[6] = v316;
    p296[7] = v317;
    p296[8] = v318;
end;

local u365 = {
    [384] = {},
    [512] = v5
};
local u366 = {
    [384] = {},
    [512] = v4
};

local function mul(p367, p368, p369, p370) -- Line: 628
    local table_create_ret = table.create(p370);
    local v371 = 0;
    local v372 = 1;
    local v373 = 0;

    for i = 1, p370 do
        local v374 = i;

        for i2 = math.max(1, i + 1 - #p368), math.min(i, #p367) do
            v371 = v371 + p369 * p367[i2] * p368[v374 + 1 - i2];
            local _ = i2;
        end;

        local v375 = v371 % 16777216;
        table_create_ret[v374] = math.floor(v375);
        v371 = (v371 - v375) / 16777216;
        v373 = v373 + v375 * v372;
        v372 = v372 * 16777216;
    end;

    return table_create_ret, v373;
end;

local v376 = { 1 };
local v377 = 0;

while true do
    v13 = v13 + v14[v13 % 6];
    local v378 = 1;
    v378 = v378 + v14[v378 % 6];

    if v13 < v378 * v378 then
        local v379 = v13 ^ 0.3333333333333333;
        local v380 = mul(table.create(1, (math.floor(v379 * 1099511627776))), v376, 1, 2);
        local _, v381 = mul(v380, mul(v380, v380, 1, 4), -1, 4);
        local v382 = v380[2] % 65536 * 65536 + math.floor(v380[1] / 256);
        local v383 = v380[1] % 256 * 16777216 + math.floor(v381 * 4.625929269271485e-18 * v379 / v13);

        if v377 < 16 then
            local math_sqrt_ret = math.sqrt(v13);
            local v384 = mul(table.create(1, (math.floor(math_sqrt_ret * 1099511627776))), v376, 1, 2);
            local _, v385 = mul(v384, v384, -1, 2);
            local v386 = v384[2] % 65536 * 65536 + math.floor(v384[1] / 256);
            local v387 = v384[1] % 256 * 16777216 + math.floor(v385 * 7.62939453125e-6 / math_sqrt_ret);
            local v388 = v377 % 8 + 1;
            u74[224][v388] = v387;
            v11[v388] = v386;
            v12[v388] = v387 + v386 * 0;

            if v388 > 7 then
                v11 = u365[384];
                v12 = u366[384];
            end;
        end;

        v377 = v377 + 1;
        u3[v377] = v382;
        u2[v377] = v383 % 4294967296 + v382 * 0;
    elseif v13 % v378 == 0 then
    else
        continue;
    end;

    if v377 > 79 then
        for i = 224, 256, 32 do
            local v389 = i;
            local v390 = {};
            local v391 = {};

            for i2 = 1, 8 do
                v390[i2] = bit32_bxor(v4[i2], 2779096485) % 4294967296;
                v391[i2] = bit32_bxor(v5[i2], 2779096485) % 4294967296;
                local _ = i2;
            end;

            sha512_feed_128(v390, v391, "SHA-512/" .. tostring(v389) .. "\128" .. string.rep("\0", 115) .. "X", 0, 128);
            u366[v389] = v390;
            u365[v389] = v391;
        end;

        for i = 1, 64 do
            local math_sin_ret = math.sin(i);
            local v392 = math.abs(math_sin_ret) * 65536;
            local math_modf_ret, v393 = math.modf(v392);
            u8[i] = math_modf_ret * 65536 + math.floor(v393 * 65536);
            local _ = i;
        end;

        local u394 = 29;

        local function next_bit() -- Line: 720
            -- upvalues: u394 (ref), bit32_bxor (copy)
            local v395 = u394 % 2;
            u394 = bit32_bxor((u394 - v395) / 2, v395 * 142);

            return v395;
        end;

        for i = 1, 24 do
            local v396 = i;
            local v397 = nil;
            local v398 = 0;

            for i2 = 1, 6 do
                v397 = v397 and v397 * v397 * 2 or 1;
                local v399 = u394 % 2;
                u394 = bit32_bxor((u394 - v399) / 2, v399 * 142);
                v398 = v398 + v399 * v397;
                local _ = i2;
            end;

            local v400 = u394 % 2;
            u394 = bit32_bxor((u394 - v400) / 2, v400 * 142);
            local v401 = v400 * v397;
            u7[v396] = v401;
            u6[v396] = v398 + v401 * 0;
        end;

        local function HexToBinFunction(p402) -- Line: 1153
            local v403 = tonumber(p402, 16);

            return string.char(v403);
        end;

        local u404 = {
            ["+"] = 62,
            ["-"] = 62,
            [62] = "+",
            ["/"] = 63,
            _ = 63,
            [63] = "/",
            ["="] = -1,
            ["."] = -1,
            [-1] = "="
        };
        local v405 = 0;

        local function keccak(u406, u407, u408, p409) -- Line: 1010
            -- upvalues: keccak_feed (copy)
            if type(u407) ~= "number" then
                error("Argument \'digest_size_in_bytes\' must be a number", 2);
            end;

            local u410 = "";
            local table_create_ret = table.create(25, 0);
            local table_create_ret2 = table.create(25, 0);
            local u411 = nil;

            local function partial(p412) -- Line: 1036
                -- upvalues: u410 (ref), u406 (copy), keccak_feed (ref), table_create_ret (copy), table_create_ret2 (copy), partial (copy), u408 (copy), u407 (copy), u411 (ref)
                if not p412 then
                    if u410 then
                        local v413 = u408 and 31 or 6;
                        u410 = u410 .. (#u410 + 1 == u406 and string.char(v413 + 128) or string.char(v413) .. string.rep("\0", (-2 - #u410) % u406) .. "\128");
                        keccak_feed(table_create_ret, table_create_ret2, u410, 0, #u410, u406);
                        u410 = nil;
                        local u414 = 0;
                        local math_floor_ret = math.floor(u406 / 8);
                        local u415 = {};

                        local function get_next_qwords_of_digest(p416) -- Line: 1067
                            -- upvalues: u414 (ref), math_floor_ret (copy), keccak_feed (ref), table_create_ret (ref), table_create_ret2 (ref), u415 (copy)
                            if math_floor_ret <= u414 then
                                keccak_feed(table_create_ret, table_create_ret2, "\0\0\0\0\0\0\0\0", 0, 8, 8);
                                u414 = 0;
                            end;

                            local math_min_ret = math.min(p416, math_floor_ret - u414);
                            local math_floor_ret2 = math.floor(math_min_ret);

                            for i = 1, math_floor_ret2 do
                                u415[i] = string.format("%08x", table_create_ret2[u414 + i] % 4294967296) .. string.format("%08x", table_create_ret[u414 + i] % 4294967296);
                                local _ = i;
                            end;

                            u414 = u414 + math_floor_ret2;

                            return string.gsub(table.concat(u415, "", 1, math_floor_ret2), "(..)(..)(..)(..)(..)(..)(..)(..)", "%8%7%6%5%4%3%2%1"), math_floor_ret2 * 8;
                        end;

                        local u417 = {};
                        local u418 = "";
                        local u419 = 0;

                        local function get_next_part_of_digest(p420) -- Line: 1094
                            -- upvalues: u419 (ref), u418 (ref), u417 (copy), get_next_qwords_of_digest (copy), get_next_part_of_digest (copy)
                            local v421 = p420 or 1;

                            if v421 > u419 then
                                local v422;

                                if u419 > 0 then
                                    v422 = 1;
                                    u417[v422] = u418;
                                    v421 = v421 - u419;
                                else
                                    v422 = 0;
                                end;

                                while v421 >= 8 do
                                    local v423, v424 = get_next_qwords_of_digest(v421 / 8);
                                    v422 = v422 + 1;
                                    u417[v422] = v423;
                                    v421 = v421 - v424;
                                end;

                                if v421 > 0 then
                                    local v425, v426 = get_next_qwords_of_digest(1);
                                    u418 = v425;
                                    u419 = v426;
                                    v422 = v422 + 1;
                                    u417[v422] = get_next_part_of_digest(v421);
                                else
                                    u418 = "";
                                    u419 = 0;
                                end;

                                return table.concat(u417, "", 1, v422);
                            end;

                            u419 = u419 - v421;
                            local v427 = v421 * 2;
                            local string_sub_ret = string.sub(u418, 1, v427);
                            u418 = string.sub(u418, v427 + 1);

                            return string_sub_ret;
                        end;

                        if u407 < 0 then
                            u411 = get_next_part_of_digest;
                        else
                            u411 = get_next_part_of_digest(u407);
                        end;
                    end;

                    return u411;
                end;

                local v428 = #p412;

                if u410 then
                    local v429;

                    if u410 == "" or u406 > #u410 + v428 then
                        v429 = 0;
                    else
                        v429 = u406 - #u410;
                        keccak_feed(table_create_ret, table_create_ret2, u410 .. string.sub(p412, 1, v429), 0, u406, u406);
                        u410 = "";
                    end;

                    local v430 = v428 - v429;
                    local v431 = v430 % u406;
                    keccak_feed(table_create_ret, table_create_ret2, p412, v429, v430 - v431, u406);
                    u410 = u410 .. string.sub(p412, v428 + 1 - v431);

                    return partial;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p409 then
                return partial(p409)();
            end;

            return partial;
        end;

        local function hex2bin(p432) -- Line: 1157
            -- upvalues: HexToBinFunction (copy)
            return string.gsub(p432, "%x%x", HexToBinFunction);
        end;

        local function md5(p433) -- Line: 883
            -- upvalues: u15 (copy), md5_feed_64 (copy)
            local table_create_ret = table.create(4);
            local u434 = 0;
            local u435 = "";
            local v436 = u15[2];
            local v437 = u15[3];
            local v438 = u15[4];
            table_create_ret[1] = u15[1];
            table_create_ret[2] = v436;
            table_create_ret[3] = v437;
            table_create_ret[4] = v438;

            local function u445(p439) -- Line: 889
                -- upvalues: u435 (ref), u434 (ref), md5_feed_64 (ref), table_create_ret (ref), u445 (copy)
                if not p439 then
                    if u435 then
                        local table_create_ret2 = table.create(11);
                        table_create_ret2[1] = u435;
                        table_create_ret2[2] = "\128";
                        table_create_ret2[3] = string.rep("\0", (-9 - u434) % 64);
                        u435 = nil;
                        u434 = u434 * 8;

                        for i = 4, 11 do
                            local v440 = u434 % 256;
                            table_create_ret2[i] = string.char(v440);
                            u434 = (u434 - v440) / 256;
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret2);
                        md5_feed_64(table_create_ret, table_concat_ret, 0, #table_concat_ret);

                        for i = 1, 4 do
                            table_create_ret[i] = string.format("%08x", table_create_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_create_ret = string.gsub(table.concat(table_create_ret), "(..)(..)(..)(..)", "%4%3%2%1");
                    end;

                    return table_create_ret;
                end;

                local v441 = #p439;

                if u435 then
                    u434 = u434 + v441;
                    local v442;

                    if u435 == "" or #u435 + v441 < 64 then
                        v442 = 0;
                    else
                        v442 = 64 - #u435;
                        md5_feed_64(table_create_ret, u435 .. string.sub(p439, 1, v442), 0, 64);
                        u435 = "";
                    end;

                    local v443 = v441 - v442;
                    local v444 = v443 % 64;
                    md5_feed_64(table_create_ret, p439, v442, v443 - v444);
                    u435 = u435 .. string.sub(p439, v441 + 1 - v444);

                    return u445;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p433 then
                return u445(p433)();
            end;

            return u445;
        end;

        local function sha1(p446) -- Line: 947
            -- upvalues: u15 (copy), sha1_feed_64 (copy)
            local table_pack_ret = table.pack(table.unpack(u15));
            local u447 = 0;
            local u448 = "";

            local function u454(p449) -- Line: 951
                -- upvalues: u448 (ref), u447 (ref), sha1_feed_64 (ref), table_pack_ret (ref), u454 (copy)
                if not p449 then
                    if u448 then
                        local table_create_ret = table.create(10);
                        table_create_ret[1] = u448;
                        table_create_ret[2] = "\128";
                        table_create_ret[3] = string.rep("\0", (-9 - u447) % 64 + 1);
                        u448 = nil;
                        u447 = u447 * 1.1102230246251565e-16;

                        for i = 4, 10 do
                            u447 = u447 % 1 * 256;
                            local math_floor_ret = math.floor(u447);
                            table_create_ret[i] = string.char(math_floor_ret);
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret);
                        sha1_feed_64(table_pack_ret, table_concat_ret, 0, #table_concat_ret);

                        for i = 1, 5 do
                            table_pack_ret[i] = string.format("%08x", table_pack_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_pack_ret = table.concat(table_pack_ret);
                    end;

                    return table_pack_ret;
                end;

                local v450 = #p449;

                if u448 then
                    u447 = u447 + v450;
                    local v451;

                    if u448 == "" or #u448 + v450 < 64 then
                        v451 = 0;
                    else
                        v451 = 64 - #u448;
                        sha1_feed_64(table_pack_ret, u448 .. string.sub(p449, 1, v451), 0, 64);
                        u448 = "";
                    end;

                    local v452 = v450 - v451;
                    local v453 = v452 % 64;
                    sha1_feed_64(table_pack_ret, p449, v451, v452 - v453);
                    u448 = u448 .. string.sub(p449, v450 + 1 - v453);

                    return u454;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p446 then
                return u454(p446)();
            end;

            return u454;
        end;

        local function sha256ext(u455, p456) -- Line: 741
            -- upvalues: u74 (copy), sha256_feed_64 (copy)
            local v457 = u74[u455];
            local u458 = 0;
            local u459 = "";
            local table_create_ret = table.create(8);
            local v460 = v457[2];
            local v461 = v457[3];
            local v462 = v457[4];
            local v463 = v457[5];
            local v464 = v457[6];
            local v465 = v457[7];
            local v466 = v457[8];
            table_create_ret[1] = v457[1];
            table_create_ret[2] = v460;
            table_create_ret[3] = v461;
            table_create_ret[4] = v462;
            table_create_ret[5] = v463;
            table_create_ret[6] = v464;
            table_create_ret[7] = v465;
            table_create_ret[8] = v466;

            local function u473(p467) -- Line: 748
                -- upvalues: u459 (ref), u458 (ref), sha256_feed_64 (ref), table_create_ret (ref), u473 (copy), u455 (copy)
                if not p467 then
                    if u459 then
                        local table_create_ret2 = table.create(10);
                        table_create_ret2[1] = u459;
                        table_create_ret2[2] = "\128";
                        table_create_ret2[3] = string.rep("\0", (-9 - u458) % 64 + 1);
                        u459 = nil;
                        u458 = u458 * 1.1102230246251565e-16;

                        for i = 4, 10 do
                            u458 = u458 % 1 * 256;
                            local math_floor_ret = math.floor(u458);
                            table_create_ret2[i] = string.char(math_floor_ret);
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret2);
                        sha256_feed_64(table_create_ret, table_concat_ret, 0, #table_concat_ret);
                        local v468 = u455 / 32;

                        for i = 1, v468 do
                            table_create_ret[i] = string.format("%08x", table_create_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_create_ret = table.concat(table_create_ret, "", 1, v468);
                    end;

                    return table_create_ret;
                end;

                local v469 = #p467;

                if u459 then
                    u458 = u458 + v469;
                    local v470;

                    if u459 == "" or #u459 + v469 < 64 then
                        v470 = 0;
                    else
                        v470 = 64 - #u459;
                        sha256_feed_64(table_create_ret, u459 .. string.sub(p467, 1, v470), 0, 64);
                        u459 = "";
                    end;

                    local v471 = v469 - v470;
                    local v472 = v471 % 64;
                    sha256_feed_64(table_create_ret, p467, v470, v471 - v472);
                    u459 = u459 .. string.sub(p467, v469 + 1 - v472);

                    return u473;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p456 then
                return u473(p456)();
            end;

            return u473;
        end;

        local function sha512ext(u474, p475) -- Line: 809
            -- upvalues: u366 (copy), u365 (copy), sha512_feed_128 (copy)
            local u476 = 0;
            local u477 = "";
            local table_pack_ret = table.pack(table.unpack(u366[u474]));
            local table_pack_ret2 = table.pack(table.unpack(u365[u474]));

            local function u483(p478) -- Line: 814
                -- upvalues: u477 (ref), u476 (ref), sha512_feed_128 (ref), table_pack_ret (ref), table_pack_ret2 (ref), u483 (copy), u474 (copy)
                if not p478 then
                    if u477 then
                        local table_create_ret = table.create(10);
                        table_create_ret[1] = u477;
                        table_create_ret[2] = "\128";
                        table_create_ret[3] = string.rep("\0", (-17 - u476) % 128 + 9);
                        u477 = nil;
                        u476 = u476 * 1.1102230246251565e-16;

                        for i = 4, 10 do
                            u476 = u476 % 1 * 256;
                            local math_floor_ret = math.floor(u476);
                            table_create_ret[i] = string.char(math_floor_ret);
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret);
                        sha512_feed_128(table_pack_ret, table_pack_ret2, table_concat_ret, 0, #table_concat_ret);
                        local math_ceil_ret = math.ceil(u474 / 64);

                        for i = 1, math_ceil_ret do
                            table_pack_ret[i] = string.format("%08x", table_pack_ret2[i] % 4294967296) .. string.format("%08x", table_pack_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_pack_ret2 = nil;
                        local table_concat_ret2 = table.concat(table_pack_ret, "", 1, math_ceil_ret);
                        table_pack_ret = string.sub(table_concat_ret2, 1, u474 / 4);
                    end;

                    return table_pack_ret;
                end;

                local v479 = #p478;

                if u477 then
                    u476 = u476 + v479;
                    local v480;

                    if u477 == "" or #u477 + v479 < 128 then
                        v480 = 0;
                    else
                        v480 = 128 - #u477;
                        sha512_feed_128(table_pack_ret, table_pack_ret2, u477 .. string.sub(p478, 1, v480), 0, 128);
                        u477 = "";
                    end;

                    local v481 = v479 - v480;
                    local v482 = v481 % 128;
                    sha512_feed_128(table_pack_ret, table_pack_ret2, p478, v480, v481 - v482);
                    u477 = u477 .. string.sub(p478, v479 + 1 - v482);

                    return u483;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p475 then
                return u483(p475)();
            end;

            return u483;
        end;

        for _, v in v1({ "AZ", "az", "09" }) do
            for i = string.byte(v), string.byte(v, 2) do
                local string_char_ret = string.char(i);
                u404[string_char_ret] = v405;
                u404[v405] = string_char_ret;
                v405 = v405 + 1;
                local _ = i;
            end;
        end;

        local function pad_and_xor(p484, p485, u486) -- Line: 1218
            -- upvalues: bit32_bxor (copy)
            return string.gsub(p484, ".", function(p487) -- Line: 1219
                -- upvalues: u486 (copy), bit32_bxor (ref)
                local v488 = bit32_bxor(string.byte(p487), u486);

                return string.char(v488);
            end) .. string.rep(string.char(u486), p485 - #p484);
        end;

        local u489 = {};

        local function base642bin(p490) -- Line: 1194
            -- upvalues: u404 (copy)
            local v491 = 3;
            local v492 = {};

            for i, v in string.gmatch(string.gsub(p490, "%s+", ""), "()(.)") do
                local v493 = u404[v];

                if v493 < 0 then
                    v491 = v491 - 1;
                    v493 = 0;
                end;

                local v494 = i % 4;

                if v494 > 0 then
                    v492[-v494] = v493;
                else
                    local v495 = v492[-1] * 4 + math.floor(v492[-2] / 16);
                    local v496 = v492[-2] % 16 * 16 + math.floor(v492[-3] / 4);
                    local string_char_ret = string.char(v495, v496, v492[-3] % 4 * 64 + v493);
                    v492[#v492 + 1] = string.sub(string_char_ret, 1, v491);
                end;
            end;

            return table.concat(v492);
        end;

        local function bin2base64(p497) -- Line: 1177
            -- upvalues: u404 (copy)
            local table_create_ret = table.create((math.ceil(#p497 / 3)));
            local v498 = 0;

            for i = 1, #p497, 3 do
                local v499 = string.sub(p497, i, i + 2) .. "\0";
                local string_byte_ret, v500, v501, v502 = string.byte(v499, 1, -1);
                v498 = v498 + 1;
                table_create_ret[v498] = u404[math.floor(string_byte_ret / 4)] .. u404[string_byte_ret % 4 * 16 + math.floor(v500 / 16)] .. u404[v501 and (v500 % 16 * 4 + math.floor(v501 / 64) or -1) or -1] .. u404[v502 and v501 % 64 or -1];
                local _ = i;
            end;

            return table.concat(table_create_ret);
        end;

        local u503 = nil;

        for i = 0, 255 do
            u489[string.format("%02x", i)] = string.char(i);
            local _ = i;
        end;

        local v537 = {
            md5 = md5,
            sha1 = sha1,

            sha224 = function(p504) -- Line: 1273, Name: sha224
                -- upvalues: sha256ext (copy)
                return sha256ext(224, p504);
            end,

            sha256 = function(p505) -- Line: 1277, Name: sha256
                -- upvalues: sha256ext (copy)
                return sha256ext(256, p505);
            end,

            sha512_224 = function(p506) -- Line: 1281, Name: sha512_224
                -- upvalues: sha512ext (copy)
                return sha512ext(224, p506);
            end,

            sha512_256 = function(p507) -- Line: 1285, Name: sha512_256
                -- upvalues: sha512ext (copy)
                return sha512ext(256, p507);
            end,

            sha384 = function(p508) -- Line: 1289, Name: sha384
                -- upvalues: sha512ext (copy)
                return sha512ext(384, p508);
            end,

            sha512 = function(p509) -- Line: 1293, Name: sha512
                -- upvalues: sha512ext (copy)
                return sha512ext(512, p509);
            end,

            sha3_224 = function(p510) -- Line: 1298, Name: sha3_224
                -- upvalues: keccak (copy)
                return keccak(144, 28, false, p510);
            end,

            sha3_256 = function(p511) -- Line: 1302, Name: sha3_256
                -- upvalues: keccak (copy)
                return keccak(136, 32, false, p511);
            end,

            sha3_384 = function(p512) -- Line: 1306, Name: sha3_384
                -- upvalues: keccak (copy)
                return keccak(104, 48, false, p512);
            end,

            sha3_512 = function(p513) -- Line: 1310, Name: sha3_512
                -- upvalues: keccak (copy)
                return keccak(72, 64, false, p513);
            end,

            shake128 = function(p514, p515) -- Line: 1314, Name: shake128
                -- upvalues: keccak (copy)
                return keccak(168, p515, true, p514);
            end,

            shake256 = function(p516, p517) -- Line: 1318, Name: shake256
                -- upvalues: keccak (copy)
                return keccak(136, p517, true, p516);
            end,

            hmac = function(u518, u519, p520, p521) -- Line: 1231, Name: hmac
                -- upvalues: u503 (ref), HexToBinFunction (copy), bit32_bxor (copy), u489 (copy)
                local u522 = u503[u518];

                if not u522 then
                    error("Unknown hash function", 2);
                end;

                if u522 < #u519 then
                    u519 = string.gsub(u518(u519), "%x%x", HexToBinFunction);
                end;

                local v523 = u519;
                local u524 = 54;
                local u527 = u518()(string.gsub(v523, ".", function(p525) -- Line: 1219
                    -- upvalues: u524 (copy), bit32_bxor (ref)
                    local v526 = bit32_bxor(string.byte(p525), u524);

                    return string.char(v526);
                end) .. string.rep("6", u522 - #v523));
                local u528 = nil;

                local function u535(p529) -- Line: 1246
                    -- upvalues: u528 (ref), u518 (copy), u519 (ref), u522 (copy), bit32_bxor (ref), u527 (copy), HexToBinFunction (ref), u535 (copy)
                    if not p529 then
                        local v530 = u528;

                        if not v530 then
                            local v531 = u519;
                            local u532 = 92;
                            v530 = u518((string.gsub(v531, ".", function(p533) -- Line: 1219
                                -- upvalues: u532 (copy), bit32_bxor (ref)
                                local v534 = bit32_bxor(string.byte(p533), u532);

                                return string.char(v534);
                            end) .. string.rep("\\", u522 - #v531)) .. string.gsub(u527(), "%x%x", HexToBinFunction));
                        end;

                        u528 = v530;

                        return u528;
                    end;

                    if not u528 then
                        u527(p529);

                        return u535;
                    end;

                    error("Adding more chunks is not allowed after receiving the result", 2);
                end;

                if not p520 then
                    return u535;
                end;

                local v536 = u535(p520)();

                if p521 then
                    v536 = string.gsub(v536, "%x%x", u489) or v536;
                end;

                return v536;
            end,

            hex_to_bin = hex2bin,
            base64_to_bin = base642bin,
            bin_to_base64 = bin2base64,
            base64_encode = script_Base64.Encode,
            base64_decode = script_Base64.Decode
        };
        u503 = {
            [v537.md5] = 64,
            [v537.sha1] = 64,
            [v537.sha224] = 64,
            [v537.sha256] = 64,
            [v537.sha512_224] = 128,
            [v537.sha512_256] = 128,
            [v537.sha384] = 128,
            [v537.sha512] = 128,
            [v537.sha3_224] = 144,
            [v537.sha3_256] = 136,
            [v537.sha3_384] = 104,
            [v537.sha3_512] = 72
        };

        return v537;
    end;
end;