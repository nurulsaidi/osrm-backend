/*
    open source routing machine
    Copyright (C) Dennis Luxen, others 2010

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU AFFERO General Public License as published by
the Free Software Foundation; either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
or see http://www.gnu.org/licenses/agpl.txt.
 */

#ifndef SHARED_DATA_TYPE_H_
#define SHARED_DATA_TYPE_H_

enum SharedDataType {
    NAMES_INDEX = 0,
    NAME_INDEX_SIZE,
    NAMES_LIST,
    NAMES_LIST_SIZE,
    NAME_ID_LIST,
    NAME_ID_LIST_SIZE,
    VIA_NODE_LIST,
    VIA_NODE_LIST_SIZE,
    GRAPH_NODE_LIST,
    GRAPH_NODE_LIST_SIZE,
    GRAPH_EDGE_LIST,
    GRAPH_EDGE_LIST_SIZE,
    CHECK_SUM,
    TIMESTAMP,
    TIMESTAMP_SIZE,
    COORDINATE_LIST,
    COORDINATE_LIST_SIZE,
    TURN_INSTRUCTION_LIST,
    TURN_INSTRUCTION_LIST_SIZE,
    R_SEARCH_TREE,
    R_SEARCH_TREE_SIZE
};

#endif /* SHARED_DATA_TYPE_H_ */
