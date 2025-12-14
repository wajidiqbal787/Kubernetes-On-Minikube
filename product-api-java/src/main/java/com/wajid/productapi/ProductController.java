package com.wajid.productapi;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final Map<Integer, Map<String, Object>> store = new HashMap<>();
    private int idCounter = 1;

    @GetMapping
    public Collection<Map<String, Object>> list() {
        return store.values();
    }

    @PostMapping
    public Map<String, Object> create(@RequestBody Map<String, Object> body) {
        int id = idCounter++;
        body.put("id", id);
        store.put(id, body);
        return body;
    }

    @GetMapping("/{id}")
    public Map<String, Object> get(@PathVariable int id) {
        return store.getOrDefault(id, Collections.emptyMap());
    }

    @PutMapping("/{id}")
    public Map<String, Object> update(@PathVariable int id, @RequestBody Map<String, Object> body) {
        body.put("id", id);
        store.put(id, body);
        return body;
    }

    @DeleteMapping("/{id}")
    public Map<String, String> delete(@PathVariable int id) {
        store.remove(id);
        return Map.of("status", "deleted");
    }
}
